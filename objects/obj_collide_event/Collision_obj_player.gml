obj_elevator.layer = layer_get_id("Collision");
obj_elevator.sprite_index = elevador_fechando;
obj_elevator.image_index = 2;
obj_player.is_paused = true;
obj_player.sprite_index = spr_idle_down;
audio_stop_sound(snd_passo)
instance_destroy();
