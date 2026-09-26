function save_game(index){
	var buffer = buffer_create(1024, buffer_grow, 1);
	
	buffer_write(buffer, buffer_s32, string(decision_manager.lasting_choices))
	buffer_write(buffer, buffer_bool, obj_npc.has_interacted);
	buffer_write(buffer, buffer_bool, obj_npc.has_applied_effect);
	
	buffer_save(buffer, "save" + string(index) + ".dat")
}