/* Order of things:
 * 1. Draw diffuse surface
 * 2. Draw normal maps
 * 
*/
#macro RP_DIFFUSE 0
#macro RP_NORMAL 1
	global.renderPass = RP_DIFFUSE;
#macro AMBIANCE_R 160
#macro AMBIANCE_G 160
#macro AMBIANCE_B 144 * 1.75
	global.playerLightColors[0] = 255;
	global.playerLightColors[1] = 255;
	global.playerLightColors[2] = 255;


function NM_set_light(argument0, argument1, argument2, argument3, argument4) {
	var i,X,Y,r,c;
	i = argument0;
	X = argument1;
	Y = argument2;
	r = argument3;
	c = argument4;
	NMlights[i*3] = X;
	NMlights[i*3+1] = Y;
	NMlights[i*3+2] = r;
	NMcolor[i*3] = colour_get_red(c)/255;
	NMcolor[i*3+1] = colour_get_green(c)/255;
	NMcolor[i*3+2] = colour_get_blue(c)/255;


}



//NM_start()//Setup for required variables
NMlights = array_create(24, 0);
NMcolor = array_create(24, 0);
NMamb = c_black;
var width = room_width;
var height = room_height;
NMdif = surface_create(width, height);
NMnorm = surface_create(width, height);
unorm = shader_get_sampler_index(shdNormal,"norm");
uamb = shader_get_uniform(shdNormal,"ambiance");
ulights = shader_get_uniform(shdNormal,"lights");
ucolor = shader_get_uniform(shdNormal,"lcolor");
uNumEnabled = shader_get_uniform(shdNormal,"numEnabled");
uangle = shader_get_uniform(shdRotate,"angle");


playerLightColors[0] = 1;
playerLightColors[1] = 255;
playerLightColors[2] = 255;


NMamb = make_colour_rgb(AMBIANCE_R,AMBIANCE_G,AMBIANCE_B) //Set ambiance color

numLights = 1;
dynamicLights = ds_list_create();
