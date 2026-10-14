if(clicked == true){
if (wait_animation_time > 0){wait_animation_time--}
}
if(wait_animation_time == 0 && clicked){
	on_left_click();
	clicked = false;
	image_speed = 0;
	
}