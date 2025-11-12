
EnsureSingleton()

active = false
save_changes = true

replaced_objects = []
can_create_objects = []
create_in_layer = "Instances"
instance_edit_vars = {}
CustomDebugView = function() {}
if variable_global_exists("level_editor_config") {
    var config = variable_global_get("level_editor_config")
    replaced_objects = struct_get(config, "objects") ?? replaced_objects
    can_create_objects = struct_get(config, "create_objects") ?? can_create_objects
    create_in_layer = struct_get(config, "create_in_layer") ?? create_in_layer
    instance_edit_vars = struct_get(config, "instance_edit_vars") ?? instance_edit_vars
    CustomDebugView = struct_get(config, "CustomDebugView") ?? CustomDebugView
}

mouse_over_instances = ds_list_create()
chosen_pos = 0
chosen_instance = noone
player_placeholder = noone

dbgview = undefined
dbgsection_instance = undefined

debug_search_capture_instance = noone

/// inst id -> struct of changes
changes = {}

function DebugShowInstance(inst) {
    //// Instance info
    dbg_section_delete(dbgsection_instance)
    dbgsection_instance = dbg_section("Instance")
    dbg_watch(ref_create(self, "chosen_instance"), "ref")
    dbg_text_input(ref_create(inst, "x"), "x", "f")
    dbg_text_input(ref_create(inst, "y"), "y", "f")
    dbg_text_input(ref_create(inst, "image_angle"), "angle", "f")
    dbg_text_input(ref_create(inst, "image_xscale"), "image_xscale", "f")
    dbg_text_input(ref_create(inst, "image_yscale"), "image_yscale", "f")

    var is_placeholder = inst.object_index == oLevelEditorInstancePlaceholder

	//// Instance vars
	var object_edit_vars = GetEditVars(is_placeholder ? inst.source_instance : inst)
    if object_edit_vars != undefined {
        /// Read edited vars for the object
        for (var i = 0; i < array_length(object_edit_vars); ++i) {
            var vars_setup = object_edit_vars[i]
            var base_ref = is_placeholder ? inst.inputs : inst
            var subrefs = struct_get(vars_setup, "subrefs")
            if subrefs != undefined {
                /// Copy the ref's structure
                base_ref = [base_ref]
                for (var j = 0; j < array_length(subrefs); ++j) {
                    array_push(base_ref, subrefs[j])
                }
            }
            DebugViewAddRefs(base_ref, vars_setup.vars)
        }
    }
}

function CreateDebugView() {
	dbgview = dbg_view("Level Editor", true, 10, 10, 300, 700)

    dbg_checkbox(ref_create(self, "save_changes"), "Save changes")
    dbg_button("Forget changes", function() {
        oLevelEditor.changes = {}
    })

    //// Search instance
    dbg_text_input(ref_create(id, "debug_search_capture_instance"), "instance id", "i")
    dbg_same_line()
    dbg_button("Capture instance", function() {
        var inst_id = oLevelEditor.debug_search_capture_instance
        with oLevelEditorInstancePlaceholder {
            if inst_id == real(source_instance) {
                oLevelEditor.SetChosenPlaceholder(id)
                CameraSetPos(x, y)
                break
            }
        }
    })

    CustomDebugView()

    //// Button to teleport player
    if player_placeholder != noone {
        var teleporter = {
            inst: player_placeholder,
            teleport: function() {
                self.inst.x = CamXCent()
                self.inst.y = CamYCent()
            }
        }
        dbg_button("Teleport player", teleporter.teleport)
    }
	
    //// Zoom buttons
    // dbg_button("Zoom in", function() {
    //     camera_obj.ChangeZoom(-1)
    // })
	// dbg_same_line()
    // dbg_button("Zoom out", function() {
    //     camera_obj.ChangeZoom(1)
    // })

    //// Instance creation buttons
    for (var i = 0; i < array_length(can_create_objects); ++i) {
        var item = can_create_objects[i]
		var creator = {
			obj: item,
			id: id,
            create: function() {
                var inst = instance_create_layer(CamXCent(), CamYCent(), oLevelEditor.create_in_layer, obj)
				var placeholder = id.ReplaceWithPlaceholder(inst)
                oLevelEditor.SaveChange(placeholder, {}, true)
			}
        }
        dbg_button(object_get_name(item), creator.create)
    }

}

function Activate() {
    active = true
    if global.pause {
        ReplaceStuff()
        try {
            physics_pause_enable(true)
        } catch (e) {
            show_debug_message("No physics in current room")
        }
    }
	CreateDebugView()
}

function Deactivate() {
    active = false
    if global.pause {
	    ReturnActualInstances()
        try {
            physics_pause_enable(false)
        } catch (e) {}
    }
	if dbg_view_exists(dbgview) {
		dbg_view_delete(dbgview)	
	}
	DropChosen()
}

function ReplaceStuff() {
    for (var i = 0; i < array_length(replaced_objects); i += 1) {
        var obj = replaced_objects[i]
        with obj {
            var placeholder = other.ReplaceWithPlaceholder(id)
        }
    }
}

function SaveChange(placeholder, inputs, is_created=false) {
	var prev_change = struct_get(changes, real(placeholder.source_instance))
	var payload = undefined
	if prev_change {
		payload = struct_get(prev_change, "__payload")
	}
    var save_vars = {
        x: placeholder.x,
        y: placeholder.y,
        sprite_index: placeholder.sprite_index,
        visible: placeholder.visible,
        image_index: placeholder.image_index,
        image_angle: placeholder.image_angle,
        image_xscale: placeholder.image_xscale,
        image_yscale: placeholder.image_yscale,
        image_blend: placeholder.image_blend,
        image_alpha: placeholder.image_alpha
    }

    if UsesPhysics(placeholder.source_instance) {
        save_vars.phy_rotation = -placeholder.image_angle
        save_vars.phy_position_x = placeholder.x
        save_vars.phy_position_y = placeholder.y
    }

    //// Save the edited vars
    var keys = variable_struct_get_names(inputs)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        var value = inputs[$ key]
        save_vars[$ key] = value
    }

    //// Add additional info if the instance was created in editor
    changes[$ real(placeholder.source_instance)] = save_vars
    if is_created {
        save_vars.__payload = {
            object_index: placeholder.source_instance.object_index
        }
		return;
    }
	/// Inherit payload for editor-created instances
	if payload != undefined {
		changes[$ real(placeholder.source_instance)].__payload = payload
	}
}

function UpdateInstanceFromStruct(inst, struct) {
    var names = variable_struct_get_names(struct)
	var uses_phy = UsesPhysics(inst)
    for (var i = 0; i < array_length(names); ++i) {
        var var_name = names[i]
		
		//// ToDo: find a better way to handle physics vars, as any var can start with phy_
		if var_name == "__payload" or (!uses_phy and string_starts_with(var_name, "phy_")) {
			continue
		}
        var value = struct[$ var_name]
        inst_set(inst, var_name, value)
    }
}

function LoadChanges() {
    /*
    Iterate through changes struct, activate placeholder,
    assign the values to the source instance, deactivate placeholder
    */
    var names = variable_struct_get_names(changes)
    for (var i = 0; i < array_length(names); ++i) {
        var inst_id = names[i]
        var change = changes[$ inst_id]
        /// If the instance doesn't exist, that means it was added via editor, create it
        if !instance_exists(inst_id) {
			var xx = struct_get(change, "x") ?? 0
			var yy = struct_get(change, "y") ?? 0
            var new_inst_id = instance_create_layer(
                xx, yy, create_in_layer, change.__payload.object_index)
            /// Resave the instance as it might have a different id
			changes[$ real(new_inst_id)] = change
			struct_remove(changes, inst_id)
			inst_id = new_inst_id
        }
        UpdateInstanceFromStruct(inst_id, change)
    }
}

function GetEditVars(inst) {
    var keys = variable_struct_get_names(instance_edit_vars)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        var obj = asset_get_index(key)
        if (obj == inst.object_index) or object_is_ancestor(inst.object_index, obj) {
            return instance_edit_vars[$ key]
        }
    }
    return undefined
}

function ReplaceWithPlaceholder(inst) {
	with inst {
		var placeholder = instance_create_layer(
			x, y, layer, oLevelEditorInstancePlaceholder,
			{sprite_index: sprite_index,
			 visible: visible,
			 image_index: image_index,
			 image_speed: 0,
			 image_angle: image_angle,
			 image_xscale: image_xscale,
			 image_yscale: image_yscale,
			 image_blend: image_blend,
			 image_alpha: image_alpha}
		)

        if object_index == oPlayer {
            other.player_placeholder = placeholder
        }
		placeholder.source_instance = id
        /// Add var inputs
		var inputs = other.GetEditVars(inst)
        if inputs != undefined {
            /*         
            inputs = [
                {subrefs: ["trace"], vars: [
                    ["time", dbg_slider_int, 0, 120]]},
            ]
            */
            for (var i = 0; i < array_length(inputs); ++i) {
                var inp = inputs[i]
                var subrefs = struct_get(inp, "subrefs")
                /// If and input is a struct sssign the whole struct to placeholder's inputs.
                // When it's chosen oLevelEditor will pick right refs from instance_edit_vars
                if subrefs != undefined {
                    placeholder.inputs[$ subrefs[0]] = inst_get(id, subrefs[0])
                } else
                /// If it's an array of instance's vars, assign them all
                for (var j = 0; j < array_length(inp.vars); ++j) {
                    var varname = inp.vars[j][0]
                    placeholder.inputs[$ varname] = inst_get(id, varname)
                }
            }
        }

        if id == oLevelEditor.chosen_instance {
            oLevelEditor.chosen_instance = placeholder
        }

		instance_deactivate_object(id)
        return placeholder
	}
}

function ReturnActualInstances() {
    player_placeholder = noone
	with oLevelEditorInstancePlaceholder {
		instance_activate_object(source_instance)
        UpdateSourceInstance()
        other.UpdateInstanceFromStruct(source_instance, inputs)
        if other.save_changes and is_changed {
            other.SaveChange(id, inputs)
        }
        instance_destroy()
	}
}

function SetChosenPlaceholder(inst) {
    chosen_instance = inst
    chosen_instance.Capture()
    chosen_instance.force_quit_dragging = true
    DebugShowInstance(chosen_instance)
}

function SetChosenInstance(inst) {
    chosen_instance = inst
    DebugShowInstance(inst)
}

function DropChosen() {
    chosen_instance = noone
    if dbg_section_exists(dbgsection_instance) {
        dbg_section_delete(dbgsection_instance)
    }
}

function DropChanges() {
    oLevelEditor.changes = {}
}

function PauseHook() {
    if !active { return }
    dbg_section_delete(dbgsection_instance)
    ReplaceStuff()
    if chosen_instance != noone {
        SetChosenPlaceholder(chosen_instance)
    }
}

function UnpauseHook() {
    if !active { return }
    if chosen_instance != noone {
        var new_chosen = chosen_instance.source_instance
        DropChosen()
        SetChosenInstance(new_chosen)
    }
    ReturnActualInstances()
}
