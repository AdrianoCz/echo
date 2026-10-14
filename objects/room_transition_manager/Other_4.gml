
if(decision_manager.came_from_loading == true){
room_goto(decision_manager.curr_room)
obj_player.x = decision_manager.target_entrance.x;
obj_player.y = decision_manager.target_entrance.y;

} else if decision_manager.came_from_loading == false {



obj_player.x = target_entrance.x;
obj_player.y = target_entrance.y;

}
