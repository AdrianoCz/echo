if (file_exists("save.json")) {

    var _arquivo = file_text_open_read("save.json");
    var _string_json = file_text_read_string(_arquivo);
    file_text_close(_arquivo);

    var _dados_carregados = json_parse(_string_json);
    
    lasting_choices = _dados_carregados.save;
    

    show_debug_message(_dados_carregados.save[0]); 
}