
EnsureSingleton()

if os_type == os_windows {
    instance_destroy()
    exit
}

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
        user_id: user_id,
        session_id: session_id,
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

    return metrics
}

sendMetrics = function() {
    var metrics = collectMetrics()
    // send
    show_debug_message($"Dry run send metrics: {metrics}")
    try {
        // collect
    } catch (e) {
        // handle errors
    }
    call_later(send_period, time_source_units_seconds, sendMetrics)
}

session_id = generateGUID()
user_id = "-"

// start sending metrics
sendMetrics()
