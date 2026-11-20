// obj_minigame_filtro - Evento STEP
var _dt = min(delta_time / 1000000, 0.1);   // independe da queda de FPS
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

spawn_rate += 0.01/60
// Efeitos visuais decaem sempre
flash = max(0, flash - _dt * 2);

if (estado == "jogando") {

    tempo -= _dt;

    // --- Pegar um pensamento ---
    if (mouse_check_button_pressed(mb_left) && arrastando == -1) {
        for (var i = array_length(pensamentos) - 1; i >= 0; i--) {
            var _p = pensamentos[i];
            if (point_distance(_mx, _my, _p.x, _p.y) <= _p.r) {
                arrastando = i;
                break;
            }
        }
    }

    // --- Arrastar / soltar ---
    if (arrastando != -1) {
        var _p = pensamentos[arrastando];
        if (mouse_check_button(mb_left)) {
            var _k = 1 - power(1 - _p.peso, _dt * 60);
            _p.x = lerp(_p.x, _mx, _k);
            _p.y = lerp(_p.y, _my, _k);
        } else {
            var _fora = (_mx < margem_saida || _mx > gui_w - margem_saida
                      || _my < margem_saida || _my > gui_h - margem_saida);
            if (_fora) {
                array_delete(pensamentos, arrastando, 1);
                removidos++;
            }
            arrastando = -1;
        }
    }

    // --- Pensamentos soltos derivam para o professor ---
    var _carga = 0;
    for (var i = 0; i < array_length(pensamentos); i++) {
        var _p = pensamentos[i];
        var _na_zona = (_p.x > zona.x1 && _p.x < zona.x2 && _p.y > zona.y1 && _p.y < zona.y2);

        if (i != arrastando && !_na_zona) {
            var _dir = point_direction(_p.x, _p.y, zona_cx, zona_cy);
            _p.x += lengthdir_x(_p.vel * _dt, _dir);
            _p.y += lengthdir_y(_p.vel * _dt, _dir);
        }
        if (_na_zona) _carga += (_p.tipo == 1) ? 2 : 1;   // memória pesa o dobro
    }

    // --- Barra de foco ---
    if (_carga > 0) {
        foco -= (dreno_base + _carga * dreno_por_pensamento) * _dt;
    } else {
        foco += recuperacao * _dt;
        foco -= dreno_base * 0.3 * _dt;
    }
    foco = clamp(foco, 0, foco_max);

    // --- Colapso de foco = falha ---
    if (foco <= 0) {
        colapsos++;
        foco = foco_max * 0.5;
        flash = 1;
        flicker_timer = 0;
    }

    var _caos = colapsos / max_colapsos;   // 0 a 1

    // --- Spawn (acelera conforme o jogador falha) ---
    spawn_timer -= _dt;
    if (spawn_timer <= 0) {
        cria_pensamento();
        spawn_timer = random_range(1.2, 2.2) / spawn_rate * (1 + dia * 0.15 + _caos);
    }

    // --- Luzes piscando ---
    flicker_timer -= _dt;
    if (flicker_timer <= 0 && _caos > 0) {
        flicker_timer = random_range(0.05, 0.6) * (1 - _caos * 0.7) + 0.03;
        escuro_alvo = (random(1) < 0.25 + _caos * 0.65) ? random_range(0.4, 0.85) : 0;
    }
    escuro = lerp(escuro, escuro_alvo, 0.5);

    // --- Queda de FPS real (opcional, desligada por padrão) ---
    aplica_fps_real(max(15, round(lerp(fps_original, 18, _caos))));

    // --- Fim do minigame ---
    if (colapsos >= max_colapsos) {
        estado = "fim";
        fim_texto = "Você não consegue mais ouvir a aula...";
        fim_timer = duracao_resultado;
        aplica_resultado();
    } else if (tempo <= 0) {
        estado = "fim";
        fim_texto = (colapsos == 0) ? "Você manteve o foco." : "A aula acabou. Mal dá pra lembrar dela.";
        fim_timer = duracao_resultado;
        aplica_resultado();
    }

} else {
    // Tela de resultado
    escuro = lerp(escuro, 0, 0.2);
    aplica_fps_real(fps_original);
    fim_timer -= _dt;
    fade_alpha = clamp(fim_timer / fade_duracao, 0, 1);   // fade-out nos últimos segundos
    if (fim_timer <= 0) instance_destroy();
}


// --- Queda de FPS simulada: controla a frequência de atualização da imagem ---
var _cv = (estado == "jogando") ? colapsos / max_colapsos : 0;
if (_cv <= 0) {
    redesenhar = true;                       // sem falhas: imagem a cada frame
    visual_timer = 0;
} else {
    var _fps_visual = lerp(60, 6, power(_cv, 0.6));   // 60 -> 6 fps visuais
    var _intervalo  = 1 / _fps_visual;

    // engasgos aleatórios: a imagem congela por um instante
    if (travado <= 0 && random(1) < _cv * 1.5 * _dt) travado = random_range(0.12, 0.35);
    travado = max(0, travado - _dt);

    visual_timer += _dt;
    if (travado <= 0 && visual_timer >= _intervalo) {
        visual_timer = visual_timer % _intervalo;
        redesenhar = true;
    }
}
