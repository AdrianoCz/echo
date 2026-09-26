function save_game(index){
    var buffer = buffer_create(1024, buffer_grow, 1);
    
	var _de_mg_save = {
		choices: decision_manager.lasting_choices,
		interacted: decision_manager.has_interacted_list
	}
	
    buffer_write(buffer, buffer_string, json_stringify(_de_mg_save));

        
    buffer_save(buffer, "save" + string(index) + ".dat");
    buffer_delete(buffer); 
}