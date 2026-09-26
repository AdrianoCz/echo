target_room = room_start
target_entrance = entrance_house
load_game_function = load_game(1)

on_left_click = function a() {
		if(file_exists("save1.dat") && layer_get_visible("play_menu") ){ 
			instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance, load_game_function});
		} else {
		instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance});}	
}