function get_interaction_result(_searched_interaction) {
    var _result = [];
    var _choices = obj_player.lasting_choices;
    var _count = array_length(_choices);
    
    for (var i = 0; i < _count; i++) {
        var _item = _choices[i];
        if (_item[1] == _searched_interaction) {
            array_push(_result, _item);
        }
    }
    
    return _result;
}
function check_has_interacted(_player_id){
	for (i = 0; i < array_length(decision_manager.has_interacted_list); i++){
		if decision_manager.has_interacted_list[i] == self.character_id {
			self.has_interacted = true	
		}
	
	}
}
function check_has_applied_effect(_player_id){
	for (i = 0; i < array_length(decision_manager.applied_effect_list); i++){
		if decision_manager.applied_effect_list[i] == self.character_id {
			self.has_applied_effect = true	
		}
	
	}
}