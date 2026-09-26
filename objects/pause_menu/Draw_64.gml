// 1. Dark semi-transparent background overlay
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, 1366, 768, false);
draw_set_alpha(1.0); // Reset alpha

// Common variables
var cx = 1366 / 2;
var cy = 768 / 2;
var bw = 260; // Button width
var bh = 60;  // Button height

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// ==================== STATE 1: MAIN MENU ====================
if (menu_state == "main") {
    var salvar_y1 = cy - 50;
    var sair_y1 = cy + 20;
    
    // Draw "Salvar" Button (Black background + White border)
    draw_set_color(c_black);
    draw_rectangle(cx - (bw/2), salvar_y1, cx + (bw/2), salvar_y1 + bh, false);
    draw_set_color(c_white);
    draw_rectangle(cx - (bw/2), salvar_y1, cx + (bw/2), salvar_y1 + bh, true);
    draw_text(cx, salvar_y1 + (bh/2), "Salvar");

    // Draw "Sair" Button (Black background + White border)
    draw_set_color(c_black);
    draw_rectangle(cx - (bw/2), sair_y1, cx + (bw/2), sair_y1 + bh, false);
    draw_set_color(c_white);
    draw_rectangle(cx - (bw/2), sair_y1, cx + (bw/2), sair_y1 + bh, true);
    draw_text(cx, sair_y1 + (bh/2), "Sair");
}

// ==================== STATE 2: SAVE SLOTS ====================
else if (menu_state == "save_slots") {
    var slot_h = 50;
    var gap = 15;
    var start_y = cy - 120;
    
    // Draw 3 Save Slots (Black background + White border)
    for (var i = 1; i <= 3; i++) {
        var sy = start_y + (i - 1) * (slot_h + gap);
        
        draw_set_color(c_black);
        draw_rectangle(cx - (bw/2), sy, cx + (bw/2), sy + slot_h, false);
        draw_set_color(c_white);
        draw_rectangle(cx - (bw/2), sy, cx + (bw/2), sy + slot_h, true);
        draw_text(cx, sy + (slot_h/2), "Slot " + string(i));
    }
    
    // Draw "Voltar" (Back) Button at the bottom (Black background + White border)
    var back_y = start_y + 3 * (slot_h + gap);
    draw_set_color(c_black);
    draw_rectangle(cx - (bw/2), back_y, cx + (bw/2), back_y + slot_h, false);
    draw_set_color(c_white);
    draw_rectangle(cx - (bw/2), back_y, cx + (bw/2), back_y + slot_h, true);
    draw_text(cx, back_y + (slot_h/2), "Voltar");
}

// Always reset text alignments!
draw_set_halign(fa_left);
draw_set_valign(fa_top);