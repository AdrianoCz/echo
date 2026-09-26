function can_talk_validation(){
		if (array_length(get_interaction_result("first_npc_test")) > 0){
	self.interaction_blocked = false;
	if(get_interaction_result("first_npc_test")[0][2] == 0){
		self.interaction_text[0][1] = "Pitagorize minha corpa, baricentrize minha genere"
	} else if (get_interaction_result("first_npc_test")[0][2] == 1){
		self.interaction_text[0][1] = "Marolou com meu mano la, slk"
	}
} 
}