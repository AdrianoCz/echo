draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, 1366, 768, false);
draw_set_alpha(1.0);

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

draw_set_font(font_main_menu);

draw_set_color(c_dkgray);
draw_rectangle(salvar_x1, salvar_y1, salvar_x2, salvar_y2, false);
draw_set_color(c_white);
draw_rectangle(salvar_x1 - 1, salvar_y1 - 1, salvar_x2 + 1 , salvar_y2 + 1, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(cx, salvar_y1 + (bh / 2), "Salvar");

draw_set_color(c_dkgray);
draw_rectangle(sair_x1, sair_y1, sair_x2, sair_y2, false);
draw_set_color(c_white);
draw_rectangle(sair_x1 - 1, sair_y1 - 1, sair_x2 + 1, sair_y2 + 1, true);
draw_text(cx, sair_y1 + (bh / 2), "Sair");

draw_set_halign(fa_left);
draw_set_valign(fa_top);