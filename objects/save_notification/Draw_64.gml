if (alpha <= 0) exit;

draw_set_alpha(alpha);

var box_width  = 220;
var box_height = 50;
var box_x      = (1366 - box_width) / 2; 
var box_y      = 768 - 110;             


draw_set_color(c_black);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);


draw_set_color(c_white);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


draw_text(box_x + (box_width / 2), box_y + (box_height / 2), "Jogo Salvo");


draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1.0);