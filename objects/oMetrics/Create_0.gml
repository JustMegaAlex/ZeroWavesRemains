
EnsureSingleton()

if !DEV and os_type == os_windows {
    instance_destroy()
    exit
}

dry_run = false

var f = file_text_open_read("metrics_endpoint.txt")
endpoint = file_text_readln(f)

send_period = 3

generateGUID = function() {
    var r = "";
    for (var i = 0; i < 32; i++) {
        if (i == 8 || i == 12 || i == 16 || i == 20) r += "-";
        r += choose("0", "1", "2", "3", "4", "5", "6", "7",
            "8", "9", "A", "B", "C", "D", "E", "F");
    }
    return r;
}

collectMetrics = function() {
    /* 
    All plays
    Play data:
        - waves survived
        - time played
        - diff
        - weapon usage by time
        - zoom level
        - boost time used
        - weapon upgrades
    

    */

    var ct = current_time / 1000
    var player_exists = instance_exists(oPlayer)
    var metrics = {
        v: "0.5.2",
        time_total: ct,
        play_time: ct - global.play_start_time / 1000,
        plays_total: global.plays_total,
        in_play: room == rmGame,
        in_pause: global.pause,
        player_exists: player_exists,
        waves_remains: global.waves_remains,
        difficulty: global.difficulty,
    }
    if player_exists {
        var weapons = {}
        for (var i = 0; i < array_length(oPlayer.weapons_array); ++i) {
            var weap = oPlayer.weapons_array[i]
            if weap == noone { continue }
            weapons[$ weap.name] = {
                upgrades: weap.upgrades,
                time: weap.active_usage_time,
            }
        }
        metrics.weapons = weapons
        metrics.boost_time_used = oPlayer.boost_time_used
    }
    if instance_exists(oCamera) {
        metrics.camera_zoom = oCamera.zoom
    }
    if global.tutorial and instance_exists(oTutorial) {
        metrics.tute_step = oTutorial.step_index
    }
    var cur_sec = current_second >= 10 ? current_second : $"0{current_second}"
    var cur_minute = current_minute >= 10 ? current_minute: $"0{current_minute}"
    var cur_hour = current_hour >= 10 ? current_hour: $"0{current_hour}"
    var cur_month = current_month >= 10 ? current_month: $"0{current_month}"
    var cur_day = current_day >= 10 ? current_day: $"0{current_day}"
    return {
        user_id: user_id,
        session_id: session_id,
        datetime: $"{current_year}-{cur_month}-{cur_day} {cur_sec}:{cur_hour}:{cur_minute}",
        data: metrics
    }
}

request = function(metrics) {
    http_request(endpoint, "POST", -1, json_stringify(metrics))
}

_sendMetrics = function() {
    var metrics = collectMetrics()
    if dry_run {
        show_debug_message($"Dry run send metrics: {metrics}")
    } else {
        request(metrics)
    }
}

sendMetrics = function() {
    /// Dry run with crash on error
    if dry_run {
        _sendMetrics()
        return;
    }
        
    if DEV {
        _sendMetrics()
    } else {
       try {
           _sendMetrics()
       } catch(err) {
           
       }
    }
    // Keep sending
    call_later(send_period, time_source_units_seconds, sendMetrics)
}

session_id = generateGUID()
user_id = "-"

// start sending metrics
sendMetrics()
