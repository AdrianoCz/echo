function can_talk_validation(){
	if (array_length(get_interaction_result("first_npc_test")) > 0){
	self.interaction_blocked = true;
	}
}