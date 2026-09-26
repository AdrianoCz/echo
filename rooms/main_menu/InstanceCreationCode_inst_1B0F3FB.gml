target_room = room_start
target_entrance = entrance_house

on_left_click = function a() { instance_create_depth(0,0,0,room_transition_manager, {target_room, target_entrance});}