timer++

if(is_fading_out){
	image_alpha =lerp(0,1, timer/ fade_length)
	if (timer = fade_length){
	timer = 0
	is_fading_out = false;
	room_goto(target_room);
	}
} else{
	image_alpha = lerp(1, 0, timer/fade_length);
	if(timer == fade_length){
		instance_destroy();
	}
}