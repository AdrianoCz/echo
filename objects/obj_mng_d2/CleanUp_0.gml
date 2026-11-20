// obj_minigame_filtro - Evento CLEAN UP
if (surface_exists(surf)) surface_free(surf);
if (queda_fps_real) game_set_speed(gamespeed_fps, fps_original);
display_set_gui_size(gui_w_orig, gui_h_orig);
