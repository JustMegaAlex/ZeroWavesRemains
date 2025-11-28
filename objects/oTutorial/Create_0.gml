
step_template = {
        gui: function(w, h) {
        },
        step: function() {
        },
        done: function() {
            return false
        }
}
steps = [
    {
        l: 0, r: 0, u: 0, d: 0,
        gui: function(w, h) {
            draw_text(w*0.5, h*0.7, "WASD to move")
        },
        step: function() {
            l = l or oInput.Hold("left")
            r = r or oInput.Hold("right")
            u = u or oInput.Hold("up")
            d = d or oInput.Hold("down")
        },
        done: function() {
            return (l + r + u + d) == 4
        }
    },
    {
        pressed: false,
        gui: function(w, h) {
            draw_text(w*0.5, h*0.7, "Left mouse to shoot")
        },
        step: function() {
            pressed = pressed or oInput.Hold("lclick")
        },
        done: function() {
            return pressed
        }
    },
/*
    {
        gui: function(w, h) {
        },
        step: function() {
        }
        done: function() {
        }
    }
*/
]

step = steps[0]
step_index = 0
