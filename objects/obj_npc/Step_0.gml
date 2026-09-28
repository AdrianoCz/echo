can_talk_validation()

if (obj_player.currently_talking == id){
if (obj_player.current_text[obj_player.current_text_line][0] == "text_amelie"){
			obj_player.current_npc_name = "AMÉLIE"
			obj_player.current_portrait = Ameliev1_31

} else {
			obj_player.current_npc_name = character_name
			obj_player.current_portrait = portrait
}

}