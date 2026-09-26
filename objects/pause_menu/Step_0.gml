if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var cx = 1366 / 2;
    var cy = 768 / 2;
    var bw = 260;
    var bh = 60;
    
    var salvar_x1 = cx - (bw / 2);
    var salvar_y1 = cy - 50;
    var salvar_x2 = cx + (bw / 2);
    var salvar_y2 = salvar_y1 + bh;
    
    var sair_x1 = cx - (bw / 2);
    var sair_y1 = cy + 20;
    var sair_x2 = cx + (bw / 2);
    var sair_y2 = sair_y1 + bh;
    

    if (mx >= salvar_x1 && mx <= salvar_x2 && my >= salvar_y1 && my <= salvar_y2) {
       var save_data = {
		   save: decision_manager.lasting_choices
	   }   
	   var save_json = json_stringify(save_data)
	   var _arquivo = file_text_open_write("save.json");
	   file_text_write_string(_arquivo, save_json);
	   file_text_close(_arquivo);
	   keyboard_key_press(vk_escape)
    }
    
    if (mx >= sair_x1 && mx <= sair_x2 && my >= sair_y1 && my <= sair_y2) {
       game_end()
    }
}