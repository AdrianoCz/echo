function can_talk_validation(){
		if (array_length(get_interaction_result("first_npc_test")) > 0){
	self.interaction_blocked = false;
	if(get_interaction_result("first_npc_test")[0][2] == 0){
		self.interaction_text[0][1] = "Escolha 1"
		self.on_interaction_effect = function a(){change_sanity(5); return "a"}
	} else if (get_interaction_result("first_npc_test")[0][2] == 1){
		self.interaction_text[0][1] = "Escolha 2"
		self.on_interaction_effect = function b(){change_sanity(-5); return "a"}
	}
} 
}