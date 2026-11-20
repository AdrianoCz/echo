// obj_minigame_sintonizador - Evento DRAW GUI

// 1) Fundo (placeholder ou sprite)
desenhar_fundo();

// 2) Vinheta vermelha que pulsa conforme a crise
var _crise_n = crise / 100;
draw_set_alpha(_crise_n * 0.25 * (0.6 + 0.4 * dsin(current_time * 0.4)));
draw_set_color(c_red);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

if (estado == "jogando") {

    // 3) Osciloscópio
    var _sx = scope_x, _sy = scope_y, _sw = scope_w, _sh = scope_h;
    var _cy = _sy + _sh * 0.5;

    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(10, 18, 16));
    draw_rectangle(_sx, _sy, _sx + _sw, _sy + _sh, false);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(30, 60, 50));
    for (var gx = 0; gx <= _sw; gx += 75) draw_line(_sx + gx, _sy, _sx + gx, _sy + _sh);
    for (var gy = 0; gy <= _sh; gy += 50) draw_line(_sx, _sy + gy, _sx + _sw, _sy + gy);
    draw_line(_sx, _cy, _sx + _sw, _cy);
    draw_set_color(c_white);
    draw_rectangle(_sx, _sy, _sx + _sw, _sy + _sh, true);

    // 4) Ondas (mesma fase: alinhadas = idênticas)
    var _fase  = tempo_total * 120;
    var _tfreq = lerp(freq_min, freq_max, alvo_f);
    var _tamp  = lerp(amp_min, amp_max, alvo_a);
    var _pfreq = lerp(freq_min, freq_max, dials[0].v);
    var _pamp  = lerp(amp_min, amp_max, dials[1].v);
    var _ruido = _crise_n * 10;                       // onda do jogador treme com a crise
    var _cor_p = alinhado ? c_lime : c_orange;
    var _tx0 = 0, _ty0 = 0, _px0 = 0, _py0 = 0;

    for (var px = 0; px <= _sw; px += 6) {
        var _u  = px / _sw;
        var _x  = _sx + px;
        var _ty = _cy - _tamp * dsin(_tfreq * _u * 360 + _fase);
        var _py = _cy - _pamp * dsin(_pfreq * _u * 360 + _fase) + random_range(-_ruido, _ruido);
        if (px > 0) {
            draw_set_color(c_aqua);
            draw_line_width(_tx0, _ty0, _x, _ty, 4);
            draw_set_color(_cor_p);
            draw_line_width(_px0, _py0, _x, _py, 3);
        }
        _tx0 = _x;  _ty0 = _ty;
        _px0 = _x;  _py0 = _py;
    }

    // Legenda das ondas
    draw_set_color(c_aqua);
    draw_text(_sx + 12, _sy + 8, "Onda alvo");
    draw_set_color(_cor_p);
    draw_text(_sx + 12, _sy + 28, "Sua onda");

    // 5) Barra de sincronia
    var _bx = _sx, _by = _sy + _sh + 18, _bw = _sw, _bh = 16;
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(_bx - 3, _by - 3, _bx + _bw + 3, _by + _bh + 3, false);
    draw_set_alpha(1);
    draw_set_color(merge_color(c_orange, c_lime, sincronia));
    draw_rectangle(_bx, _by, _bx + _bw * sincronia, _by + _bh, false);
    draw_set_color(c_white);
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
    draw_set_halign(fa_center);
    draw_text(_bx + _bw * 0.5, _by + _bh + 6, alinhado ? "SINAL ESTÁVEL" : "SINAL INSTÁVEL");

    // 6) Botões giratórios
    for (var i = 0; i < array_length(dials); i++) {
        var _d = dials[i];
        draw_set_color(make_color_rgb(40, 44, 52));
        draw_circle(_d.x, _d.y, _d.r, false);
        draw_set_color(c_white);
        draw_circle(_d.x, _d.y, _d.r, true);

        for (var m = 0; m <= 10; m++) {
            var _am = dial_inicio - dial_varredura * (m / 10);
            draw_line(_d.x + lengthdir_x(_d.r - 4, _am),  _d.y + lengthdir_y(_d.r - 4, _am),
                      _d.x + lengthdir_x(_d.r + 10, _am), _d.y + lengthdir_y(_d.r + 10, _am));
        }

        var _ap = dial_inicio - dial_varredura * _d.v;
        draw_set_color((i == arrastando) ? c_yellow : c_orange);
        draw_line_width(_d.x, _d.y, _d.x + lengthdir_x(_d.r - 10, _ap), _d.y + lengthdir_y(_d.r - 10, _ap), 5);
        draw_circle(_d.x, _d.y, 8, false);

        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(_d.x, _d.y + _d.r + 22, _d.nome);
        draw_text(_d.x, _d.y + _d.r + 42, "(" + _d.sub + ")");
    }

    // 7) Barra de crise (topo)
    var _cx0 = 383, _cy0 = 20, _cw = 600, _ch = 28;
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(_cx0 - 4, _cy0 - 4, _cx0 + _cw + 4, _cy0 + _ch + 4, false);
    draw_set_alpha(1);
    draw_set_color(merge_color(c_lime, c_red, _crise_n));
    draw_rectangle(_cx0, _cy0, _cx0 + _cw * _crise_n, _cy0 + _ch, false);
    draw_set_color(c_white);
    draw_rectangle(_cx0, _cy0, _cx0 + _cw, _cy0 + _ch, true);
    draw_set_halign(fa_center);
    draw_text(_cx0 + _cw * 0.5, _cy0 + _ch + 8, "CRISE DE PÂNICO");

    // 8) Instrução
    draw_text(gui_w * 0.5, 740, "Arraste em círculo ao redor dos botões (ou use a roda do mouse) para alinhar as ondas");
    draw_set_halign(fa_left);

} else {

    // 9) Cena do espelho
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);

    var _vit = (resultado == "vitoria");
    var _fade = clamp(espelho_t / 1.2, 0, 1);
    // na derrota o reflexo "falha" de vez em quando
    if (!_vit && espelho_t > 1.2 && random(1) < 0.08) _fade *= 0.6;
    desenhar_espelho(_vit, _fade);

    draw_set_color(c_white);
    draw_set_alpha(_fade);
    draw_set_halign(fa_center);
    draw_text(gui_w * 0.5, 700, _vit ? "Sua respiração volta ao ritmo. O reflexo é seu."
                                     : "O espelho mostra a sala vazia. Onde está você?");
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}

draw_set_color(c_white);
draw_set_alpha(1);
