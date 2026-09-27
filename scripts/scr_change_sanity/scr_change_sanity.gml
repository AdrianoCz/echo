function change_sanity(_delta_sanity){
	if (!(decision_manager.sanity + _delta_sanity <= 0) || !(decision_manager.sanity + _delta_sanity >=100)){
		decision_manager.sanity += _delta_sanity
	}
}