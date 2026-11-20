// obj_minigame_sintonizador - Evento CREATE
// Fundo (sprite): 1366 x 768 px
// Espelho (sprite opcional): 500 x 500 px, desenhado em x=433, y=134
//
// Como criar:
//   var _m = instance_create_depth(0, 0, -1000, obj_minigame_sintonizador);
//   _m.dia = global.dia;   // opcional (1 a 5)

if (!variable_instance_exists(id, "dia")) dia = 1;

gui_w = 1366;
gui_h = 768;
gui_w_orig = display_get_gui_width();    // guardados para restaurar ao terminar
gui_h_orig = display_get_gui_height();
display_set_gui_size(gui_w, gui_h);

// --- Ajustes rápidos (mexa aqui para balancear) --------------
crise_inicial = 50;                          // 0 = calma total, 100 = colapso
subida_base   = 4 + dia * 0.8;               // quanto a crise sobe por segundo (desalinhado)
recuperacao   = 9;                           // quanto a crise cai por segundo (alinhado)
tolerancia    = max(0.04, 0.09 - dia * 0.008);   // margem de erro para considerar "alinhado"
vel_alvo      = 0.05 + dia * 0.012;          // velocidade com que a onda alvo vaga
duracao_espelho = 5;                         // segundos da cena final do espelho

// Variação de sanidade (change_sanity)
sanidade_vitoria_calma = 10;   // venceu sem a crise passar de limite_calma
sanidade_vitoria       = 5;    // venceu, mas passou perto do colapso
sanidade_derrota       = -15;  // o espelho mostra a sala vazia
limite_calma           = 75;

// --- Faixas das ondas ----------------------------------------
freq_min = 1.5;   freq_max = 6;      // ciclos visíveis na tela
amp_min  = 20;    amp_max  = 110;    // pixels

// --- Osciloscópio (área das ondas) ---------------------------
scope_x = 233;  scope_y = 110;  scope_w = 900;  scope_h = 300;

// --- Botões giratórios ---------------------------------------
dials = [
    { x: 450, y: 590, r: 85, v: 0.15, nome: "RÁDIO",       sub: "frequência" },
    { x: 916, y: 590, r: 85, v: 0.85, nome: "RESPIRAÇÃO",  sub: "amplitude"  }
];
dial_inicio    = 225;   // ângulo (graus) do valor 0
dial_varredura = 270;   // quantos graus o botão percorre (sentido horário)
arrastando = -1;
ang_prev   = 0;

// --- Onda alvo (vaga sozinha; o jogador precisa acompanhar) ---
alvo_f = 0.7;   alvo_a = 0.35;
meta_f = 0.7;   meta_a = 0.35;
alvo_timer = 1;

// --- Estado --------------------------------------------------
estado      = "jogando";     // "jogando" -> "espelho"
resultado   = "";            // "vitoria" ou "derrota"
crise       = crise_inicial;
pico        = crise_inicial;
tempo_total = 0;
erro        = 1;
alinhado    = false;
sincronia   = 0;
espelho_t   = 0;
sanidade_aplicada = false;

usar_sprite_fundo   = false;   // troque para true quando tiver o sprite de fundo
usar_sprite_espelho = false;   // troque para true quando tiver os sprites do espelho

// --- Fundo placeholder (substituir por sprite depois) -------
desenhar_fundo = function() {
    if (usar_sprite_fundo) {
        // draw_sprite(spr_bg_sintonizador, 0, 0, 0);   // 1366 x 768
        return;
    }
    draw_set_alpha(1);
    // Parede de azulejos
    draw_set_color(make_color_rgb(120, 135, 140));
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_color(make_color_rgb(95, 108, 113));
    for (var gx = 0; gx <= gui_w; gx += 80) draw_line(gx, 0, gx, 640);
    for (var gy = 0; gy <= 640; gy += 80)  draw_line(0, gy, gui_w, gy);
    // Chão
    draw_set_color(make_color_rgb(60, 66, 72));
    draw_rectangle(0, 640, gui_w, gui_h, false);
    // Pias (silhuetas)
    draw_set_color(make_color_rgb(190, 195, 200));
    draw_rectangle(60, 560, 220, 600, false);
    draw_rectangle(1146, 560, 1306, 600, false);
    // Texto do placeholder
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gui_w * 0.5, 490, "[ PLACEHOLDER - fundo 1366x768 ]");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
};

// --- Espelho placeholder (500x500 em x=433, y=134) ----------
desenhar_espelho = function(_vitoria, _a) {
    var _x1 = 433, _y1 = 134, _x2 = 933, _y2 = 634;
    var _cx = (_x1 + _x2) * 0.5;

    if (usar_sprite_espelho) {
        // draw_sprite_ext(_vitoria ? spr_espelho_vitoria : spr_espelho_derrota, 0, _x1, _y1, 1, 1, 0, c_white, _a);
        return;
    }
    draw_set_alpha(_a);
    // Moldura e vidro
    draw_set_color(make_color_rgb(150, 150, 160));
    draw_rectangle(_x1 - 14, _y1 - 14, _x2 + 14, _y2 + 14, false);
    draw_set_color(make_color_rgb(70, 80, 92));
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    // Reflexo da sala: parede, chão e porta
    draw_set_color(make_color_rgb(95, 100, 112));
    draw_rectangle(_x1 + 20, _y1 + 20, _x2 - 20, _y2 - 120, false);
    draw_set_color(make_color_rgb(55, 58, 66));
    draw_rectangle(_x1 + 20, _y2 - 120, _x2 - 20, _y2 - 20, false);
    draw_set_color(make_color_rgb(40, 36, 34));
    draw_rectangle(_x1 + 60, _y1 + 90, _x1 + 160, _y2 - 120, false);
    // Amélie (só aparece se o jogador venceu)
    if (_vitoria) {
        draw_set_color(make_color_rgb(200, 170, 160));
        draw_circle(_cx, _y1 + 190, 38, false);
        draw_rectangle(_cx - 50, _y1 + 235, _cx + 50, _y2 - 20, false);
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_cx, _y2 + 34, _vitoria ? "[ placeholder: reflexo de Amélie ]"
                                      : "[ placeholder: sala vazia, sem Amélie ]");
    draw_set_halign(fa_left);
    draw_set_alpha(1);
};

// --- Resultado -> sanidade (aplicado uma única vez) ----------
aplica_resultado = function() {
    if (sanidade_aplicada) return;
    sanidade_aplicada = true;

    var _delta;
    if (resultado == "vitoria") {
        _delta = (pico < limite_calma) ? sanidade_vitoria_calma : sanidade_vitoria;
    } else {
        _delta = sanidade_derrota;
    }
    change_sanity(_delta);
};
