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
        
        for (var i = 1; i <= 3; i++) {
            var sy = start_y + (i - 1) * (slot_h + gap);
            
            if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= sy && my <= sy + slot_h) {
				save_game(i)
				menu_state = "main"; 
				keyboard_key_press(vk_escape)
        }}
        
        var back_y = start_y + 3 * (slot_h + gap);
        if (mx >= cx - (bw/2) && mx <= cx + (bw/2) && my >= back_y && my <= back_y + slot_h) {
            menu_state = "main"; 
        }
    }
}