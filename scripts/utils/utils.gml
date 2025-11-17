#macro struct_has variable_struct_exists
#macro inst_has variable_instance_exists
#macro struct_del variable_struct_remove
#macro inst_get variable_instance_get
#macro inst_set variable_instance_set
#macro arrlen array_length


function ArrJoin(arr, sep) {
    var len = array_length(arr)
    if (len == 0)
        return ""
    var s = string(arr[0])
    for (var i = 1; i < len; ++i) {
        s += sep + string(arr[i])
    }
    return s
}

function StringCapitalize(str) {
    /*
    Capitalizes the first letter of a string
    Examples:
    StringCapitalize("hello") -> "Hello"
    StringCapitalize("WORLD") -> "WORLD"
    StringCapitalize("test string") -> "Test string"
    StringCapitalize("") -> ""
    */
    if (string_length(str) == 0) {
        return str
    }
    var first_char = string_upper(string_char_at(str, 1))
    if (string_length(str) == 1) {
        return first_char
    }
    return first_char + string_copy(str, 2, string_length(str) - 1)
}

function IterStruct(_struct) constructor {
    struct = _struct
    names = variable_struct_get_names(self.struct)
    len = array_length(names)
    i = -1

    next = function() {
        i++
        if (i >= len)
            return undefined
        return variable_struct_get(self.struct, names[i])
    }

    key = function(shift = 0) {
        var ii = i + shift
        if (ii < 0 || ii >= len)
            return undefined
        return names[ii]
    }

    value = function(shift = 0) {
        var ii = i + shift
        if (ii < 0 || ii >= len)
            return undefined
        return variable_struct_get(self.struct, names[ii])
    }

    reset = function() {
        i = -1
    }
}

function Approach(val, to, amount) {
    var delta = to - val
    if (abs(delta) < amount)
        return to
    var sp = amount * sign(delta)
    return val + sp
}

function Approach2(val, to, ratio, treshold=infinity) {
    var delta = to - val
    if (abs(delta) < treshold)
        return to
    return val + ratio * delta
}

function ApproachAngle(val, to, amount) {
    var delta = angle_difference(to, val)
    if (abs(delta) < amount)
        return to
    var sp = amount * sign(delta)
    return val + sp
}

function ArraySum(arr) {
    var res = 0
    for (var i = 0; i < array_length(arr); ++i) {
        res += arr[i]
    }
    return res
}

function ArrayHas(arr, val) {
    for (var i = 0; i < array_length(arr); ++i) {
        if (val == arr[i])
            return true
    }
    return false
}

function ArrayCount(arr, val) {
    var count = 0
    for (var i = 0; i < array_length(arr); ++i) {
        if (val == arr[i])
            count++
    }
    return count
}

function ArrayFind(arr, val) {
    for (var i = 0; i < array_length(arr); ++i) {
        if (val == arr[i])
            return i
    }
    return -1
}

function ArrayRemove(arr, val) {
    var i = ArrayFind(arr, val)
    if (i == -1)
        return undefined
    var res = arr[i]
    array_delete(arr, i, 1)
    return res
}

function ArrayChoose(arr) {
    if ArrayEmpty(arr) {
        throw "An empty array was passed to ArrayChoose()"
    }
    return arr[irandom(array_length(arr) - 1)]
}

function ArrayExpand(arr, from) {
    for (var i = 0; i < array_length(from); ++i) {
        array_push(arr, from[i])
    }
}

function ArrayEmpty(arr) {
    return array_length(arr) == 0
}

function ArrayClear(arr) {
    return array_resize(arr, 0)
}

function Chance(p) {
    return random(1) < p
}

function DrawBoundingBox() {
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
}

function DrawTextCustom(xx, yy, text, font = -1, col = c_white, alpha = 1,
    halign = fa_top, valign = fa_left) {
    var prev_valign = draw_get_valign()
    var prev_halign = draw_get_halign()
    var prev_font = draw_get_font()
    var prev_col = draw_get_color()
    var prev_alpha = draw_get_alpha()
    draw_set_font(font)
    draw_set_halign(halign)
    draw_set_valign(valign)
    draw_set_color(col)
    draw_set_alpha(alpha)

    draw_text(xx, yy, text)

    draw_set_font(prev_font)
    draw_set_halign(prev_halign)
    draw_set_valign(prev_valign)
    draw_set_color(prev_col)
    draw_set_alpha(prev_alpha)
}

function SetTextAllign(hor, vert) {
    draw_set_halign(hor)
    draw_set_valign(vert)
}

function InstMouseDir(inst) {
    return point_direction(inst.x, inst.y, mouse_x, mouse_y)
}

function InstInstDir(inst, inst_to) {
    return point_direction(inst.x, inst.y, inst_to.x, inst_to.y)
}

function InstInstDist(inst, inst_to) {
    return point_distance(inst.x, inst.y, inst_to.x, inst_to.y)
}

function MouseDir() {
    return point_direction(id.x, id.y, mouse_x, mouse_y)
}

function MouseDist() {
    return point_distance(id.x, id.y, mouse_x, mouse_y)
}

function InstDir(from, to=undefined) {
	if to == undefined {
		to = from
		from = id
	}
    return point_direction(from.x, from.y, to.x, to.y)
}

function InstDist(from, to=undefined) {
	if to == undefined {
		to = from
		from = id
	}
    return point_distance(from.x, from.y, to.x, to.y)
}

function PointDist(xx, yy) {
    return point_distance(id.x, id.y, xx, yy)
}

function PointDir(xx, yy) {
    return point_direction(id.x, id.y, xx, yy)
}

function StructSum(struct) {
    var names = variable_struct_get_names(struct)
    var res = 0
    for (var i = 0; i < array_length(names); ++i) {
        res += struct[$ names[i]]
    }
    return res
}

function CollisionLineWidth(x0, y0, x1, y1, obj, w) {
    /*
    Make a collision_line check as if the line has thickness
    */
    var angle = point_direction(x0, y0, x1, y1)
    var angle_factor = (angle mod 180) < 90 ? 1 : -1 // 1
    var half = w * 0.5 // 5
    var xx0 = x0 - half * angle_factor // 5
    var yy0 = y0 - half // -5
    var xx1 = x1 - half * angle_factor // 15
    var yy1 = y1 - half // 5
    var inst = collision_line(xx0, yy0, xx1, yy1, obj, false, true)
    var xx2 = x0 + half * angle_factor
    var yy2 = y0 + half
    var xx3 = x1 + half * angle_factor
    var yy3 = y1 + half

    //if inst
    //  return inst
    //inst = collision_line(xx2, yy2, xx3, yy3, obj, false, true)
    //return inst

    if inst
    return {
        inst: inst,
        x1: xx1,
        x2: xx2,
        x3: xx3,
        x0: xx0,
        y0: yy0,
        y1: yy1,
        y2: yy2,
        y3: yy3
    }

    inst = collision_line(xx2, yy2, xx3, yy3, obj_planet_mask, false, true)
    return {
        inst: inst,
        x1: xx1,
        x2: xx2,
        x3: xx3,
        x0: xx0,
        y0: yy0,
        y1: yy1,
        y2: yy2,
        y3: yy3
    }
}

function MakeLateInit() {
    /*
    A shortcut for launching a 1-step alarm
    in cases when alarm is used as late initialization
    */
    alarm[0] = 1
}

function GetRandomInstance(obj) {
    return instance_find(obj, irandom(instance_number(obj) - 1))
}

function ObjectName(inst) {
    return object_get_name(inst.object_index)
}

function MouseCollision(obj_or_inst) {
    return collision_point(mouse_x, mouse_y, obj_or_inst, false, false)
}

function Timer(time, initial=undefined) constructor {
    /*
    Example usage:
    // Create
    timer = make_timer(40) // or new Timer(40)

    // Step
    if !timer.update() {
      // do stuff
      ...
      // and reset the timer
      timer.reset()
    }
    */
    self.time = time
    self.timer = initial
    if initial == undefined {
        self.timer = time
    }

    function update() {
        self.timer -= timer > 0
        return self.timer
    }

    function reset() {
        self.timer = self.time
    }

    function stop() {
        self.timer = 0
    }
}

function _animGetTreshold() {
    return SpriteFramesPerStep(sprite_index)
}

function IsAnimationEnd() {
    return abs(image_index - (image_number - 1)) < _animGetTreshold()
}

function IsAnimationAtFrame(frame) {
    var delta = image_index - frame
    return delta >= 0 && delta <= _animGetTreshold()
}

function SpriteFramesPerStep(spr) {
    if (sprite_get_speed_type(spr) == spritespeed_framespersecond) {
        return sprite_get_speed(spr) / room_speed
    } else {
        return sprite_get_speed(spr)
    }
}

function EnsureSingleton() {
    if (instance_number(object_index) > 1) {
        instance_destroy()
        return false
    }
    return true
}

function IsHtmlBuild() {
    return os_browser != browser_not_a_browser
}

//// Shortcuts
function Randomer(first, second = undefined) constructor {
    /*
    Example usage:
    // create
    spawn_randomer = randomer(10, 20) // irandomer(10, 20) for integers

    // step
    if !spawn_timer.update() {
      repeat spawn_randomer() { // call returns random number from 10 to 20
        // spawn code
      }
    }
    */
    self.from = first
    self.to = second
    if (second == undefined) {
        self.from = 0
        self.to = first
    }

    function __get() {
        return random_range(self.from, self.to)
    }
}

function IRandomer(first, second = undefined) constructor {
    self.from = first
    self.to = second
    if (second == undefined) {
        self.from = 0
        self.to = first
    }

    function __get() {
        return irandom_range(self.from, self.to)
    }
}

function MakeTimer(time, initial=undefined) {
    return new Timer(time, initial)
}

function randomer(first, second = undefined) {
    return new Randomer(first, second).__get
}

function irandomer(first, second = undefined) {
    return new IRandomer(first, second).__get
}

/// @param src - integer representing bit array, e.g. 2 -> 10, 6 -> 110
/// @param dest - index of a bit to check in src
function CheckBitwise(src, dest) {
    return src & power(2, dest)
}

function ReadFileString(filename) {
    var result = ""
    var file = file_text_open_read(filename)
    while !file_text_eof(file) {
        result += file_text_readln(file)
    }
    return result
}

function UsesPhysics(instance) {
    return !is_undefined(instance.phy_active)
}

function FormatTime(total_seconds, round_seconds = true) {
    var _minutes = total_seconds div 60
    var _seconds = total_seconds mod 60
    if round_seconds {
        _seconds = round(_seconds)
    }
    var str_minutes = (_minutes < 10) ? $"0{_minutes}" : string(_minutes)
    var str_seconds = (_seconds < 10) ? $"0{_seconds}" : string(_seconds)
    return $"{str_minutes}:{str_seconds}"
}

function SmoothApproacher(from, to, time, accel_time_fract) constructor {
    if accel_time_fract < 0 or accel_time_fract > 0.5 {
        throw "accel_time_fract must be between 0 and 1"
    }
    function init() {
        self.dist = self.to - self.from
        self.sp = 0
        self.spmax = 1 / (self.total_time * (1 - self.accel_time_fract))
        self.accel = self.spmax / (self.total_time * self.accel_time_fract)
        self.time = 0
        self.value = 0
    }

    self.from = from
    self.to = to
    self.total_time = time
    self.accel_time_fract = accel_time_fract
    self.dir = 1
    self.init()

    function start(from=undefined, to=undefined, time=undefined,
                   accel_time_fract=undefined) {
        if accel_time_fract < 0 or accel_time_fract > 0.5 {
            throw "accel_time_fract must be between 0 and 1"
        }
        self.from = from ?? self.from
        self.to = to ?? self.to
        self.total_time = time ?? self.total_time
        self.accel_time_fract = accel_time_fract ?? self.accel_time_fract
        self.dir = 1
        self.init()
    }

    function step() {
        if self.finished() {
            return self.value
        }
        self.time += self.dir
        var tfract = self.time / self.total_time
        var sp_to = 0
        if self.dir > 0 {
            sp_to = tfract < (1-self.accel_time_fract) ? self.spmax : 0
        } else {
            sp_to = (tfract < self.accel_time_fract) ? 0 : self.spmax
        }
        self.sp = Approach(self.sp, sp_to, self.accel)
        self.value += self.sp * self.dir
        self.value = clamp(self.value, self.from, self.to)
        return self.from + self.dist * self.value
    }

    function finished() {
        return self.dir ? (self.time >= self.total_time) : (self.time <= 0)
    }
}



function createPartType(ps, args) {
    function _applyArgs(pt, fun, arr, num) {
        var a1 = arr[0]
        var a2 = arr[1]
        var a3 = 0
        var a4 = 0
        var a5 = 0
        var len = array_length(arr)
        if len >= 3 { a3 = arr[2] }
        if len >= 4 { a4 = arr[3] }
        if len >= 5 { a5 = arr[4] }

        if num == 3 { fun(pt, a1, a2, a3) }
        if num == 4 { fun(pt, a1, a2, a3, a4) }
        if num == 5 { fun(pt, a1, a2, a3, a4, a5) }
    }
    var life = args[$ "life"]
    var spd = args[$ "speed"]
    var size = args[$ "size"]
    var scale = args[$ "scale"]
    var sprite = args[$ "sprite"]
    var shape = args[$ "shape"]
    var dir = args[$ "dir"]
    var angle = args[$ "angle"]
    var color = args[$ "color"]
    var alpha = args[$ "alpha"]
    var pt = part_type_create()
    if life != undefined {
        if is_array(life) {
            part_type_life(pt, life[0], life[1])
        } else {
            part_type_life(pt, life, life)
        }
    }
    if spd != undefined {
        if is_array(spd) {
            _applyArgs(pt, part_type_speed, spd, 4)
        } else {
            part_type_speed(pt, spd, spd, 0, 0)
        }
    }
    if dir != undefined {
        if is_array(dir) {
            _applyArgs(pt, part_type_direction, dir, 4)
        } else {
            part_type_direction(pt, dir, dir, 0, 0)
        }
    }
    if angle != undefined {
        if is_array(angle) {
            _applyArgs(pt, part_type_orientation, angle, 5)
        } else {
            part_type_orientation(pt, angle, angle, 0, 0, true)
        }
    }
    if color != undefined {
        if is_array(color) {
            switch array_length(color) {
                case 2: part_type_color2(pt, color[0], color[1])
                case 3: part_type_color3(pt, color[0], color[1], color[2])
            }
        } else { part_type_color1(pt, color) }
    }
    if alpha != undefined {
        if is_array(alpha) {
            switch array_length(alpha) {
                case 2: part_type_alpha2(pt, alpha[0], alpha[1]) break
                case 3: part_type_alpha3(pt, alpha[0], alpha[1], alpha[2])
            }
        } else { part_type_alpha1(pt, alpha) }
    }
    if sprite != undefined {
        if is_array(sprite) {
            _applyArgs(pt, part_type_sprite, sprite, 4)
        } else {
            part_type_sprite(pt, sprite, false, true, false)
        }
    }
    if shape != undefined {
        part_type_shape(pt, shape)
    }
    if size != undefined {
        if is_array(size) {
            _applyArgs(pt, part_type_size, size, 4)
        } else {
            part_type_size(pt, size, size, 0, 0)
        }
    }
    if scale != undefined {
        part_type_scale(pt, scale[0], scale[1])
    }
    return pt
}
