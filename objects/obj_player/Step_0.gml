if(object_exists(decision_manager)){
lasting_choices = decision_manager.lasting_choices;
}

left_input = keyboard_check(ord("A"));
right_input = keyboard_check(ord("D"));
up_input = keyboard_check(ord("W"));
down_input = keyboard_check(ord("S"));

var hinput = right_input - left_input;
var vinput = down_input - up_input;

function get_character_choice_index(_value, _index){
	return(_value[0] == current_npc_name)
}
		image_xscale = 1.333;
	image_yscale = 1.333;
if (keyboard_check(vk_shift)){
	my_velocty = 2;
	image_speed = 1.5;
} else {
	my_velocty = 1;
	image_speed = 0.85;
}

if(currently_talking == noone && !is_paused){
if(up_input){
	facing_direction = 1
} else if(down_input){
	facing_direction = 2
} else if(right_input){
	facing_direction = 4
} else if(left_input) {
	facing_direction = 3
}


if (vinput == 0 && hinput == 0){
	switch (facing_direction){
		case 1:
			sprite_index = spr_idle_up;
			break;
		case 2:
			sprite_index = spr_idle_down;
			break;
		case 3:
			sprite_index = spr_idle_left;
			break;
		case 4: 
			sprite_index = spr_idle_right;
			break;
		default:
			sprite_index = spr_idle_down;
	}
}

if (vinput != 0 || hinput != 0){

	
		switch (facing_direction){
		case 1:
			sprite_index = spr_walk_up;
			break;
		case 2:
			sprite_index = spr_walk_down;
			break;
		case 3:
			sprite_index = spr_walk_left;
			break;
		case 4: 
			sprite_index = spr_walk_right;
			break;
	}
}

move_and_collide(hinput * my_velocty, vinput * my_velocty, obj_wall);
}
if(currently_talking != noone && current_text[current_text_line][0] == "choice"){
	if(keyboard_check_pressed(ord("W"))  && current_choice > 0 ){
		current_choice--
	} else if (keyboard_check_pressed(ord("S"))  && current_choice < array_length(current_text[current_text_line]) - 3){
		current_choice++
	}
}
if (keyboard_check_pressed(ord("E"))) {
	var npc_colliding = instance_place(x,y, obj_npc);
	if(npc_colliding != noone && !npc_colliding.has_interacted && npc_colliding.interaction_blocked == false){
	if(currently_talking == noone){
		current_text = npc_colliding.interaction_text;
		current_portrait = npc_colliding.portrait;
		currently_talking = npc_colliding;
		current_npc_name = npc_colliding.character_name;
		current_npc_id = npc_colliding.character_id;
	} else if (currently_talking != noone){
		if(current_text[current_text_line][0] == "text"){
		if (current_text_index <= string_length(current_text[current_text_line][1])) {
		current_text_index = string_length(current_text[current_text_line][1]) 

		} else if (current_text_line + 1 != array_length(current_text)){
			current_text_line++;
		} else if (current_text_index != string_length(current_text[current_text_line]) && current_text_line + 1 == array_length(current_text) ){
		npc_colliding.has_interacted = true;
		array_push(decision_manager.has_interacted_list, current_npc_id)
		if(currently_talking.on_interaction_effect != "nofunc"){
			currently_talking.on_interaction_effect();
			currently_talking.has_applied_effect = true;
			array_push(decision_manager.applied_effect_list, current_npc_id);
		}		
		currently_talking = noone;
		current_text = "";
		current_text_line = 0;
		current_portrait = noone;
		current_npc_name = "";
		}
	} else if(current_text[current_text_line][0] == "choice"){
			array_push(decision_manager.lasting_choices,[current_npc_id,current_text[current_text_line][1] ,current_choice ])
			current_choice = 0;
			if (current_text_line + 1 != array_length(current_text)){
			current_text_line++;
			} else if (current_text_index != string_length(current_text[current_text_line]) && current_text_line + 1 == array_length(current_text) ){
			npc_colliding.has_interacted = true;
			array_push(decision_manager.has_interacted_list, current_npc_id)
			if(currently_talking.on_interaction_effect != "nofunc"){
				currently_talking.on_interaction_effect();
				currently_talking.has_applied_effect = true;
				array_push(decision_manager.applied_effect_list, current_npc_id);
			}
			currently_talking = noone;
			current_text = "";
			current_text_line = 0;
			current_portrait = noone;
			current_npc_name = "";
			current_choice = 0;
			
			}
		}
	}
	}
}