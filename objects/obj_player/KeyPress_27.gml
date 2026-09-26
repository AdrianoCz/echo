if (room != main_menu){
	is_paused = !is_paused
if (!instance_exists(pause_menu)){
	instance_create_depth(0, 0, 0, pause_menu)
} else if (instance_exists(pause_menu)){
	instance_destroy(pause_menu)
	instance_destroy(obj_button)
}
}