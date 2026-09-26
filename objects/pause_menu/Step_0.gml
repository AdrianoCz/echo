if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var cx = 1366 / 2;
    var cy = 768 / 2;
    var bw = 260;
    var bh = 60;
    

    if (menu_state == "main") {
        var salvar_y1 = cy - 50;
        var sair_y1 = cy + 20;
        
        if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= salvar_y1 && my <= salvar_y1 + bh) {
            menu_state = "save_slots";
        }
        
        if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= sair_y1 && my <= sair_y1 + bh) {
		  game_end()
        }
    }
    

    else if (menu_state == "save_slots") {
        var slot_h = 50;
        var gap = 15;
        var start_y = cy - 120;
        
        // Check clicks for Slot 1, 2, and 3 using a loop
        for (var i = 1; i <= 3; i++) {
            var sy = start_y + (i - 1) * (slot_h + gap);
            
            if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= sy && my <= sy + slot_h) {
				var save_data = {
				save: decision_manager.lasting_choices
				}   
				var save_json = json_stringify(save_data)
				var _arquivo = file_text_open_write("save" + string(i) + ".json");
				file_text_write_string(_arquivo, save_json);
				file_text_close(_arquivo);
				keyboard_key_press(vk_escape)
                show_debug_message("Clicked save slot: " + string(i));
            }
        }
        
        // Check click for "Voltar" (Back) button
        var back_y = start_y + 3 * (slot_h + gap);
        if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= back_y && my <= back_y + slot_h) {
            menu_state = "main"; // Go back to main pause menu
        }
    }
}
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

    }
    
    if (mx >= sair_x1 && mx <= sair_x2 && my >= sair_y1 && my <= sair_y2) {

    }
}