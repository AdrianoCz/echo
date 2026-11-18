if(keyboard_check(ord("E")) && has_pressed = false){
	image_index = 1
	elevador_corredor.sprite_index = elevador_abrindo;
	instance_destroy(apague)
	audio_play_sound(elevator_button_press, 1, false)
	has_pressed = true;
}