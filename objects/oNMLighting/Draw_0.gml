/// @description Diffuse
draw_set_alpha(1)
draw_set_color(c_white)

makeSureExistsAndSize(surf_diff)
makeSureExistsAndSize(surf_norm)

var scale = window_get_width() / CamW()

//set lights
var playerLightSize = oGameArea

NMamb = make_colour_rgb(AMBIANCE_R,AMBIANCE_G,AMBIANCE_B) // Set ambiance color

numLights = 0
NM_set_light(numLights, 
             light_pos.x, light_pos.y,
             light_radius, 
             make_colour_rgb(ambience.r, ambience.g, ambience.b))
numLights++

// draw_line(
//     light_pos.x, light_pos.y,
//     light_pos.x * 0.1, light_pos.y * 0.1
// )
light_pos.rotate(light_angular_sp)


// upd lights array
if instance_exists(oPlayer) {
    // NM_set_light(other.numLights++, 
    //     // oPlayer.x, oPlayer.y,
    //     mouse_x, mouse_y,
    //     playerLightSize, 
    //              make_colour_rgb(playerLightColors[0],playerLightColors[1],playerLightColors[2]))
}


surface_set_target(surf_diff)
draw_clear_alpha(0,0)
renderPass = RP_DIFFUSE


with oEntity {
    draw_sprite_ext(
        sprite_index, image_index,
        (x - CamX()) * scale,
        (y - CamY()) * scale,
        scale, scale,
        image_angle, image_blend, image_alpha)
}
with oEnemyBehemothGun {
    draw_sprite_ext(
        sprite_index, image_index,
        (x - CamX()) * scale,
        (y - CamY()) * scale,
        scale, scale,
        image_angle, image_blend, image_alpha)
}
with oShop {
    var angle = 0
    repeat 4 {
        drawSegment(angle, -CamX(), -CamY(), scale)
        angle += 90
    }
}

surface_reset_target()

shader_set(shdRotate)
var angle = 0
surface_set_target(surf_norm)
draw_clear_alpha(0,0)
renderPass = RP_NORMAL


with oEntity {
    if sprite_index_norm == noone {
        continue
    }
    shader_set_uniform_f(other.uangle, -image_angle)
    draw_sprite_ext(
        sprite_index_norm, image_index,
        (x - CamX()) * scale,
        (y - CamY()) * scale,
        scale, scale,
        image_angle, c_white, 1)
}
with oEnemyBehemothGun {
    if sprite_index_norm == noone {
        continue
    }
    shader_set_uniform_f(other.uangle, -image_angle)
    draw_sprite_ext(
        sprite_index_norm, image_index,
        (x - CamX()) * scale,
        (y - CamY()) * scale,
        scale, scale,
        image_angle, c_white, 1)
}
with oShop {
    var angle = 0
    repeat 4 {
        shader_set_uniform_f(other.uangle, -angle)
        drawSegmentNM(angle, -CamX(), -CamY(), scale)
        angle += 90
    }
}

surface_reset_target()

//NM_draw(0, 0)


//draw_clear_alpha(0,0)
//shader_set(shdNormal)
//texture_set_stage(unorm,surface_get_texture(surf_norm))
//shader_set_uniform_f_array(ulights,NMlights)
//shader_set_uniform_f_array(ucolor,NMcolor)
//shader_set_uniform_f(uamb,colour_get_red(NMamb)/255,colour_get_green(NMamb)/255,colour_get_blue(NMamb)/255)
//shader_set_uniform_i(uNumEnabled, min(numLights,8))
//shader_set_uniform_f(ulight_z, light_z)

shader_set(shdReplace)
texture_set_stage(utex, surface_get_texture(surf_norm))
shader_set_uniform_f(ulights1, light_pos.x, light_pos.y, light_radius)
shader_set_uniform_f(ucolor, )

// draw_surface(surf_diff, CamX(), CamY())
draw_surface_stretched(surf_diff, CamX(), CamY(), CamW(), CamH())

shader_reset()

// draw_circle(mouse_x, mouse_y, playerLightSize, true)
