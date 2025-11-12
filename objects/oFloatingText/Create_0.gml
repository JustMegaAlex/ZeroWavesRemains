EnsureSingleton()

floating_texts = []

lifetime = 120
float_speed = 0.5

function Emit(text, x, y, color=c_white) {
    array_push(floating_texts, 
        {text: text,
            x: x,
            y: y,
            color: color,
            create_time: oSys.frames_since_start})
}
