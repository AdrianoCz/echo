// obj_minigame_filtro - Evento CREATE
if (!variable_instance_exists(id, "dia")) dia = 1;

gui_w = 1366;
gui_h = 768;
gui_w_orig = display_get_gui_width();    // guardados para restaurar ao terminar
gui_h_orig = display_get_gui_height();
display_set_gui_size(gui_w, gui_h);

// --- Ajustes rápidos (mexa aqui para balancear) --------------
duracao         = 45;     // segundos de aula para sobreviver
max_colapsos    = 5;      // colapsos de foco até o minigame falhar de vez
margem_saida    = 70;     // faixa (px) nas bordas onde soltar descarta o pensamento
max_pensamentos = 14;     // limite de pensamentos na tela
duracao_resultado = 3;    // segundos da tela de resultado antes de fechar
fade_duracao = 1;         // segundos de fade-out no final da tela de resultado
fade_alpha   = 1;         // 1 = visível, 0 = totalmente transparente
spawn_rate = 2;

// Variação de sanidade (change_sanity) conforme o desempenho
sanidade_0_colapsos = 8;
sanidade_1_colapso  = 3;
sanidade_2_colapsos = -4;
sanidade_3_ou_mais  = -10;
sanidade_falha_total = -18;   // chegou em max_colapsos antes do fim da aula

// --- Estado --------------------------------------------------
estado        = "jogando";    // "jogando" ou "fim"
tempo         = duracao;
colapsos      = 0;
removidos     = 0;
fim_timer     = 0;
fim_texto     = "";
sanidade_aplicada = false;

// --- Foco ----------------------------------------------------
foco          = 100;
foco_max      = 100;
dreno_base    = 3 + dia * 0.5;     // por segundo, sempre
dreno_por_pensamento = 5 + dia;    // por segundo, por pensamento sobre o professor
recuperacao   = 10;                // por segundo, quando a zona está limpa

// Zona do professor / lousa (o que Amélie tenta enxergar)
zona = { x1: 403, y1: 90, x2: 963, y2: 330 };
zona_cx = (zona.x1 + zona.x2) * 0.5;
zona_cy = (zona.y1 + zona.y2) * 0.5;

// --- Pensamentos --------------------------------------------
pensamentos   = [];
arrastando    = -1;
spawn_timer   = 1;

frases_intrusivas = [
    "Você vai reprovar",
    "Todo mundo percebeu",
    "Você está atrasada",
    "Não é boa o bastante",
    "E se der errado?",
    "Todo dia é igual",
    "Por que você tentou?"
];
frases_memorias = [
    "Íris rindo",
    "A última mensagem",
    "Aquela noite",
    "A voz de Íris",
    "Se eu tivesse ido..."
];

// --- Caos visual / FPS --------------------------------------
// A queda de FPS é SIMULADA: a velocidade real do jogo (game_set_speed) não é
// alterada, só a taxa com que a imagem do minigame é atualizada. Isso evita
// qualquer efeito colateral no resto do jogo depois que o minigame termina.
// Se quiser também mexer na velocidade real, ponha queda_fps_real = true.
queda_fps_real = false;
fps_original  = game_get_speed(gamespeed_fps);
fps_aplicado  = fps_original;
surf          = -1;     // surface onde a cena é desenhada
redesenhar    = true;
visual_timer  = 0;
travado       = 0;      // tempo restante de "engasgo" (imagem congelada)
escuro        = 0;      // alpha do "apagão" das luzes
escuro_alvo   = 0;
flicker_timer = 1;
flash         = 0;      // flash branco ao colapsar
usar_sprite_fundo = false;   // troque para true quando tiver o sprite

// --- Fundo placeholder (substituir por sprite depois) -------
desenhar_fundo = function() {
    if (usar_sprite_fundo) {
        // draw_sprite(spr_bg_filtro_atencao, 0, 0, 0);   // 1366 x 768
        return;
    }
    // Parede / sala
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(58, 62, 70));
    draw_rectangle(0, 0, gui_w, gui_h, false);
    // Chão
    draw_set_color(make_color_rgb(40, 42, 48));
    draw_rectangle(0, 560, gui_w, gui_h, false);
    // Lousa
    draw_set_color(make_color_rgb(30, 60, 50));
    draw_rectangle(zona.x1, zona.y1, zona.x2, zona.y2, false);
    draw_set_color(make_color_rgb(120, 90, 60));
    draw_rectangle(zona.x1, zona.y1, zona.x2, zona.y2, true);
    // Professor (silhueta)
    draw_set_color(make_color_rgb(20, 20, 24));
    draw_circle(zona_cx, zona.y2 + 40, 28, false);
    draw_rectangle(zona_cx - 34, zona.y2 + 68, zona_cx + 34, zona.y2 + 170, false);
    // Carteiras
    draw_set_color(make_color_rgb(80, 70, 60));
    for (var i = 0; i < 4; i++) {
        draw_rectangle(180 + i * 290, 600, 330 + i * 290, 640, false);
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(zona_cx, zona_cy, "[ PLACEHOLDER - fundo 1366x768 ]");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
};

// --- Funções auxiliares -------------------------------------
cria_pensamento = function() {
    if (array_length(pensamentos) >= max_pensamentos) return;

    var _memoria = (random(1) < 0.3);
    // nasce perto de uma das bordas laterais/inferior, longe da zona
    var _lado = irandom(2);
    var _x, _y;
    switch (_lado) {
        case 0:  _x = random_range(110, 220);          _y = random_range(200, 650); break;
        case 1:  _x = random_range(gui_w - 220, gui_w - 110); _y = random_range(200, 650); break;
        default: _x = random_range(300, gui_w - 300);  _y = random_range(560, 700); break;
    }

    array_push(pensamentos, {
        x: _x,
        y: _y,
        r: _memoria ? 58 : 46,
        tipo: _memoria ? 1 : 0,                      // 0 = intrusivo, 1 = memória de Íris
        texto: _memoria ? frases_memorias[irandom(array_length(frases_memorias) - 1)]
                        : frases_intrusivas[irandom(array_length(frases_intrusivas) - 1)],
        vel: (_memoria ? 100 : 150) + dia * 4,         // px/s rumo ao professor
        peso: _memoria ? 0.15 : 0.45,                // memórias "pesam" mais ao arrastar
        fase: random(360)
    });
};

aplica_fps_real = function(_alvo) {
    if (!queda_fps_real) return;
    if (fps_aplicado != _alvo) {            // só chama quando o valor muda
        game_set_speed(gamespeed_fps, _alvo);
        fps_aplicado = _alvo;
    }
};

aplica_resultado = function() {
    if (sanidade_aplicada) return;
    sanidade_aplicada = true;

    var _delta;
    if (colapsos >= max_colapsos) {
        _delta = sanidade_falha_total;
    } else if (colapsos == 0) {
        _delta = sanidade_0_colapsos;
    } else if (colapsos == 1) {
        _delta = sanidade_1_colapso;
    } else if (colapsos == 2) {
        _delta = sanidade_2_colapsos;
    } else {
        _delta = sanidade_3_ou_mais;
    }
    change_sanity(_delta);
};
