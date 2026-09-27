if(room != main_menu) {
draw_set_font(font_npc_name)
draw_set_colour(c_white)
draw_set_alpha(0.75)
draw_rectangle(8, 18, 147, 87, false)
draw_set_colour(c_black)
draw_rectangle(10, 20, 145, 85, false)
draw_set_alpha(1)
draw_set_colour(c_white)
draw_text(20, 20, "Sanidade")
draw_set_colour(c_red)
draw_text(60, 50, string(decision_manager.sanity))
}