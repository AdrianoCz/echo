if (currently_talking != noone){
	var delta_x = 192 
	
	var x1 = 0 + delta_x * 2;
	var y1 = window_get_height() - 224;
	var x2 = window_get_width() - delta_x;
	var y2 = window_get_height() - 64;
	
	rectangles = [
	[x1,y1,x2,y1-4, c_black],
	[x1,y1,x2,y2, c_white]
	]
	
	for(var i =0; i<2; i++){
	var rect = rectangles[i]
	draw_set_colour(rect[4])
	draw_rectangle(rect[0], rect[1], rect[2], rect[3], false);
	}
//	draw_set_colour(c_black)
	//draw_rectangle(x1,y1,x2,y1+4,false);
	
//	draw_set_colour(c_white);
//	draw_rectangle(x1,y1,x2,y2,false);
	draw_sprite(current_portrait, 0, 0 + delta_x, y1 + sprite_get_height(current_portrait)/2)
	var text_x = x1 + 32;
	var text_y = y1+32;
	
	draw_set_colour(c_black);
	

	draw_text(text_x, text_y, string_copy(current_text[current_text_line],1, current_text_index));
	current_text_index++;
}
