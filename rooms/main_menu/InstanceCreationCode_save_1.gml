target_room = room_start
target_entrance = entrance_house

on_left_click = function a() {
	if (layer_get_visible("play_menu")  && !instance_exists(play_button) ){
		if (file_exists("save1.json")) {

    var _arquivo = file_text_open_read("save1.json");
    var _string_json = file_text_read_string(_arquivo);
    file_text_close(_arquivo);

    var _dados_carregados = json_parse(_string_json);
    
    decision_manager_live.lasting_choices = _dados_carregados.save;
    
    instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance});
} else {
					var save_data = {
				save: decision_manager.lasting_choices
				}   
				var save_json = json_stringify(save_data)
				var _arquivo = file_text_open_write("save1.json");
				file_text_write_string(_arquivo, save_json);
				file_text_close(_arquivo);
				instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance})
}
	}
}