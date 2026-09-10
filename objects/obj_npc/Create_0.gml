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