if (last_text_line != current_text_line){
	current_text_index = 0;
	last_text_line = current_text_line
}
if (currently_talking != noone){
	var delta_x = 192 
	
	var x1 = 0 + delta_x * 2;
	var y1 = window_get_height() - 224;
	var x2 = window_get_width() - delta_x;
	var y2 = window_get_height() - 64;
	
	rectangles = [
	[x1-1,y1-1,x2+1,y2+1, c_white],
	[x1,y1,x2,y2, c_black],
	[delta_x-1,y1+7,delta_x+151,y2-7, c_white],
	[delta_x,y1+8,delta_x + 150,y2-8, c_black]
	]
	
	for(var i =0; i<4; i++){
	var rect = rectangles[i]
	draw_set_colour(rect[4])
	draw_rectangle(rect[0], rect[1], rect[2], rect[3], false);
	}
//	draw_set_colour(c_black)
	//draw_rectangle(x1,y1,x2,y1+4,false);
	
//	draw_set_colour(c_white);
//	draw_rectangle(x1,y1,x2,y2,false);
	draw_sprite_ext(current_portrait, 0, delta_x + 3.75 , y2 - 7 , 1.5, 1.5 ,0,c_white, 1)

	var text_x = x1 + 32;
	var text_y = y1+48;
	
	draw_set_colour(c_white);

	draw_set_font(font_npc_name);
	
	draw_text( text_x, text_y-32, current_npc_name);
	
	draw_set_font(font_regular_interaction);
	draw_text_ext(text_x, text_y, string_copy(current_text[current_text_line],1, current_text_index),16,726);

	if(current_text_index <= string_length(current_text[current_text_line])){current_text_index++};
}
