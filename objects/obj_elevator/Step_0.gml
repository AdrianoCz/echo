
target_room = room_third;
target_entrance = acessaai;
if sprite_index = elevador_abrindo && image_index >= 10{ image_speed = 0; obj_elevator_button.image_index =0;}

else if sprite_index = elevador_fechando && image_index >= 10{ image_speed = 0; obj_elevator_button.image_index =0; instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance});}
else {image_speed = 1}