if(keyboard_check(ord("E"))){
	image_index = 1
	elevador_corredor.sprite_index = elevador_abrindo;
	instance_destroy(apague)
}