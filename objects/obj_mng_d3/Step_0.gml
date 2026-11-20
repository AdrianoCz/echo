// obj_minigame_sintonizador - Evento STEP
var _dt = min(delta_time / 1000000, 0.1);
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (estado == "jogando") {

    tempo_total += _dt;

    // --- Pegar um botão ---
    if (mouse_check_button_pressed(mb_left) && arrastando == -1) {
        for (var i = 0; i < array_length(dials); i++) {
            var _d = dials[i];
            if (point_distance(_mx, _my, _d.x, _d.y) <= _d.r + 10) {
                arrastando = i;
                ang_prev = point_direction(_d.x, _d.y, _mx, _my);
                break;
            }
        }
    }

    // --- Girar o botão (arrastando em círculo ao redor dele) ---
    if (arrastando != -1) {
        var _dg = dials[arrastando];
        if (mouse_check_button(mb_left)) {
            if (point_distance(_mx, _my, _dg.x, _dg.y) > 20) {
                var _ang  = point_direction(_dg.x, _dg.y, _mx, _my);
                var _diff = angle_difference(_ang, ang_prev);
                _dg.v = clamp(_dg.v - _diff / dial_varredura, 0, 1);   // horário aumenta
                ang_prev = _ang;
            }
        } else {
            arrastando = -1;
        }
    }

    // --- Ajuste fino com a roda do mouse (sobre o botão) ---
    for (var j = 0; j < array_length(dials); j++) {
        var _dw = dials[j];
        if (point_distance(_mx, _my, _dw.x, _dw.y) <= _dw.r + 10) {
            if (mouse_wheel_up())   _dw.v = clamp(_dw.v + 0.02, 0, 1);
            if (mouse_wheel_down()) _dw.v = clamp(_dw.v - 0.02, 0, 1);
        }
    }

    // --- A onda alvo vaga sozinha ---
    alvo_timer -= _dt;
    if (alvo_timer <= 0) {
        alvo_timer = random_range(2.5, 5);
        meta_f = random_range(0.1, 0.9);
        meta_a = random_range(0.1, 0.9);
    }
    alvo_f += clamp(meta_f - alvo_f, -vel_alvo * _dt, vel_alvo * _dt);
    alvo_a += clamp(meta_a - alvo_a, -vel_alvo * _dt, vel_alvo * _dt);

    // --- Quão alinhadas estão as ondas ---
    var _ef = dials[0].v - alvo_f;
    var _ea = dials[1].v - alvo_a;
    erro      = sqrt(_ef * _ef + _ea * _ea);
    alinhado  = (erro <= tolerancia);
    sincronia = 1 - clamp(erro / 0.4, 0, 1);

    // --- Crise de pânico ---
    if (alinhado) {
        crise -= recuperacao * _dt;
    } else {
        crise += subida_base * (0.4 + erro * 2) * _dt;
    }
    crise = clamp(crise, 0, 100);
    pico  = max(pico, crise);

    // --- Fim ---
    if (crise <= 0) {
        resultado = "vitoria";
        estado = "espelho";
        aplica_resultado();
    } else if (crise >= 100) {
        resultado = "derrota";
        estado = "espelho";
        aplica_resultado();
    }

} else {
    // Cena do espelho
    espelho_t += _dt;
    if (espelho_t >= duracao_espelho) instance_destroy();
}
