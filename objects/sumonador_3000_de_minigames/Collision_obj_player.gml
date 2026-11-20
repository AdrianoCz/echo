if(keyboard_check(ord("E")) && !instance_exists(minigame)){
	instance_create_layer(30, 30, "Instances", minigame);
}