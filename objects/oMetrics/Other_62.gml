
if !DEV {
    exit
}

var status = async_load[? "status"]
var result = async_load[? "result"]
var http_status = async_load[? "http_status"]
var url = async_load[? "url"]

show_debug_message($"Response: {status} {http_status} result={result}")
