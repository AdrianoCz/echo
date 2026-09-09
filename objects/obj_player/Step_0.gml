left_input = keyboard_check(ord("A"));
right_input = keyboard_check(ord("D"));
up_input = keyboard_check(ord("W"));
down_input = keyboard_check(ord("S"));

var hinput = right_input - left_input;
var vinput = down_input - up_input;

function get_character_choice_index(_value, _index){
	return(_value[0] == current_npc_name)
}

if(currently_talking == noone){
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

move_and_collide(hinput, vinput, obj_wall);
}
if(currently_talking != noone && current_text[current_text_line][0] == "choice"){
	if(keyboard_check_pressed(ord("W"))  && current_choice > 0 ){
		current_choice--
	} else if (keyboard_check_pressed(ord("S"))  && current_choice < array_length(current_text[current_text_line]) -2 ){
		current_choice++
	}
}
if (keyboard_check_pressed(ord("E"))) {
	var npc_colliding = instance_place(x,y, obj_npc);
	if(!npc_colliding.has_interacted){
	if(npc_colliding != noone && currently_talking == noone){
		current_text = npc_colliding.interaction_text;
		current_portrait = npc_colliding.portrait;
		currently_talking = npc_colliding;
		current_npc_name = npc_colliding.character_name;
	} else if (currently_talking != noone){
		if(current_text[current_text_line][0] == "text"){
		if (current_text_index <= string_length(current_text[current_text_line][1])) {
		current_text_index = string_length(current_text[current_text_line][1]) 

		} else if (current_text_line + 1 != array_length(current_text)){
			current_text_line++;
		} else if (current_text_index != string_length(current_text[current_text_line]) && current_text_line + 1 == array_length(current_text) ){
		npc_colliding.has_interacted = true;
		currently_talking = noone;
		current_text = "";
		current_text_line = 0;
		current_portrait = noone;
		current_npc_name = "";
		}
	} else if(current_text[current_text_line][0] == "choice"){
			array_push(lasting_choices,[current_npc_name,array_length(array_filter(lasting_choices, get_character_choice_index)) + 1,current_choice ])
			current_choice = 0;
			if (current_text_line + 1 != array_length(current_text)){
			current_text_line++;
			} else if (current_text_index != string_length(current_text[current_text_line]) && current_text_line + 1 == array_length(current_text) ){
			npc_colliding.has_interacted = true;
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