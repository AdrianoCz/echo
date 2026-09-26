function load_game(index){
	    var _context = {
        saved_index: index
    };
    return method(_context, function a(){ 
        target_room = room_start;
        target_entrance = entrance_house;
        
		
        var buffer = buffer_load("save" + string(saved_index) + ".dat");
        buffer_seek(buffer, buffer_seek_start, 0);
        
		var things = json_parse(buffer_read(buffer, buffer_string))
        decision_manager.lasting_choices = things.choices
        decision_manager.has_interacted_list = things.interacted
		
        buffer_delete(buffer);
    }); 	
}
