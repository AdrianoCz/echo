if(!instance_exists(room_transition_manager) && position_meeting(obj_player.x, obj_player.y, id)){
	instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance});
}