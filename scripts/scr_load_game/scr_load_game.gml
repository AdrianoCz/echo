function load_game(index){
	if(file_exists("save" + string(index) + ".dat")){
	
	var buffer = buffer_load("save" + string(index) + ".dat");
	buffer_seek(buffer, buffer_seek_start,0);
	
	decision_manager.lasting_choices = json_parse(buffer_read(buffer, buffer_s32))
	obj_npc.has_interacted = buffer_read(buffer, buffer_bool)
	obj_npc.has_applied_effect = buffer_read(buffer, buffer_bool)
	
	buffer_delete(buffer)
	instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance})
} else{
	instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance})
}
	 	
}