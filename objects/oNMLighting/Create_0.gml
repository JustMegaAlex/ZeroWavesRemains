/* Order of things:
 * 1. Draw diffuse surface
 * 2. Draw normal maps
 * 
*/
#macro RP_DIFFUSE 0
#macro RP_NORMAL 1
global.renderPass = RP_DIFFUSE
#macro AMBIANCE_R 160
#macro AMBIANCE_G 160
#macro AMBIANCE_B 160
global.playerLightColors[0] = 255
global.playerLightColors[1] = 255
global.playerLightColors[2] = 255


function NM_set_light(argument0, argument1, argument2, argument3, argument4) {
	var i,X,Y,r,c
	i = argument0
	X = argument1
	Y = argument2
	r = argument3
	c = argument4
	NMlights[i*3] = X
	NMlights[i*3+1] = Y
	NMlights[i*3+2] = r
	NMcolor[i*3] = colour_get_red(c)/255
	NMcolor[i*3+1] = colour_get_green(c)/255
	NMcolor[i*3+2] = colour_get_blue(c)/255
}

function makeSureExistsAndSize(surf) {
    var w = window_get_width()
    var h = window_get_height()
    if (w <= 0 or h <= 0) {
        surf = surface_create(1, 1)
        return surf
    }
    if (!surface_exists(surf)) {
        surf = surface_create(w, h)
    }
    var surfw = surface_get_width(surf)
    var surfh = surface_get_height(surf)
    if surfw != w {
        surface_resize(surf, w, h)
    }
    var wratio = CamW() / surfw
    var hratio = CamH() / surfh
    if abs(wratio - hratio) > 0.01 {
        surfh = CamH() / wratio
        surface_resize(surf, surfw, surfh)
    }
    return surf
}



//NM_start()//Setup for required variables
max_lights = 1
NMlights = array_create(3 * max_lights, 0)
NMcolor = array_create(3 * max_lights, 0)
NMamb = c_black
var width = window_get_width()
var height = window_get_height()
surf_diff = surface_create(width, height)
surf_norm = surface_create(width, height)
unorm = shader_get_sampler_index(shdNormal,"norm")
uamb = shader_get_uniform(shdNormal,"ambiance")
ulights = shader_get_uniform(shdNormal,"lights")
ucolor = shader_get_uniform(shdNormal,"lcolor")
uNumEnabled = shader_get_uniform(shdNormal,"numEnabled")
ulight_z = shader_get_uniform(shdNormal,"light_z")
uangle = shader_get_uniform(shdRotate,"angle")

utex = shader_get_sampler_index(shdNormal, "tex")
ulights1 = shader_get_uniform(shdNormal,"lights")
ucolor = shader_get_uniform(shdNormal,"lcolor")
ulight_z1 = shader_get_uniform(shdNormal,"light_z")

NMamb = make_colour_rgb(AMBIANCE_R,AMBIANCE_G,AMBIANCE_B) //Set ambiance color

numLights = 1
dynamicLights = ds_list_create()

ambience = {
    r: 200, g: 200, b: 200
}
light_z = -400
light_pos = new Vec2(oGameArea.radius*1.5, random(360), true)
var light_rotation_time = 60 * 60
light_angular_sp = 360 / light_rotation_time
light_radius = oGameArea.radius * 3
