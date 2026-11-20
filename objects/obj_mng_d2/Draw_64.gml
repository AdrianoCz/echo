// obj_minigame_filtro - Evento DRAW GUI
// A cena inteira é desenhada numa surface, que só é atualizada quando
// "redesenhar" é true (controlado no Step). É isso que simula a queda de FPS.
if (!surface_exists(surf)) {
    surf = surface_create(gui_w, gui_h);
    redesenhar = true;
}

if (redesenhar) {
    surface_set_target(surf);
    draw_clear_alpha(c_black, 1);
    gpu_set_colorwriteenable(true, true, true, false);   // não deixa o alpha da surface cair

// 1) Fundo (placeholder ou sprite)
desenhar_fundo();

// 2) Destaque da zona do professor (mostra onde os pensamentos atrapalham)
draw_set_alpha(0.15);
draw_set_color(c_yellow);
draw_rectangle(zona.x1, zona.y1, zona.x2, zona.y2, false);

// 3) Bordas de descarte (brilham mais ao arrastar)
var _a_borda = (arrastando != -1) ? 0.35 : 0.12;
draw_set_alpha(_a_borda);
draw_set_color(c_aqua);
draw_rectangle(0, 0, margem_saida, gui_h, false);
draw_rectangle(gui_w - margem_saida, 0, gui_w, gui_h, false);
draw_rectangle(0, 0, gui_w, margem_saida, false);
draw_rectangle(0, gui_h - margem_saida, gui_w, gui_h, false);
draw_set_alpha(1);

// 4) Pensamentos
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var i = 0; i < array_length(pensamentos); i++) {
    var _p = pensamentos[i];
    var _pulso = 1 + 0.05 * dsin(current_time * 0.2 + _p.fase);
    var _r = _p.r * _pulso;

    if (_p.tipo == 1) draw_set_color(make_color_rgb(90, 140, 230));   // memória de Íris
    else              draw_set_color(make_color_rgb(190, 60, 70));    // intrusivo

    draw_set_alpha(i == arrastando ? 0.95 : 0.8);
    draw_circle(_p.x, _p.y, _r, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_circle(_p.x, _p.y, _r, true);
    draw_text_ext(_p.x, _p.y, _p.texto, 16, _r * 1.7);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 5) Barra de foco (topo)
var _bx = 383, _by = 20, _bw = 600, _bh = 28;
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(_bx - 4, _by - 4, _bx + _bw + 4, _by + _bh + 4, false);
draw_set_alpha(1);
draw_set_color(merge_color(c_red, c_lime, foco / foco_max));
draw_rectangle(_bx, _by, _bx + _bw * (foco / foco_max), _by + _bh, false);
draw_set_color(c_white);
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
draw_set_halign(fa_center);
draw_text(_bx + _bw * 0.5, _by + _bh + 8, "FOCO NO PROFESSOR");

// 6) Tempo restante e colapsos
draw_set_halign(fa_left);
draw_text(30, 20, "Aula: " + string(ceil(max(0, tempo))) + "s");
draw_set_halign(fa_right);
draw_text(gui_w - 30, 20, "Colapsos: " + string(colapsos) + "/" + string(max_colapsos));
draw_set_halign(fa_left);

// 7) Apagão das luzes
if (escuro > 0.01) {
    draw_set_alpha(escuro);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}

// 8) Flash de colapso
if (flash > 0) {
    draw_set_alpha(flash * 0.5);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}

// 9) Tela de resultado
if (estado == "fim") {
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gui_w * 0.5, gui_h * 0.5, fim_texto);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_color(c_white);
draw_set_alpha(1);

    gpu_set_colorwriteenable(true, true, true, true);
    surface_reset_target();
    redesenhar = false;
}

if (fade_alpha >= 1) {
    gpu_set_blendenable(false);     // a cena é opaca: ignora qualquer alpha residual
    draw_surface(surf, 0, 0);
    gpu_set_blendenable(true);
} else {
    draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, fade_alpha);   // fade-out
}
draw_set_color(c_white);
draw_set_alpha(1);
