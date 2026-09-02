left_input = keyboard_check(ord("A"));
right_input = keyboard_check(ord("D"));
up_input = keyboard_check(ord("W"));
down_input = keyboard_check(ord("S"));

var hinput = right_input - left_input;
var vinput = down_input - up_input;

if(up_input){
	facing_direction = 1
} else if(right_input){
	facing_direction = 4
} else if(down_input){
	facing_direction = 2
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