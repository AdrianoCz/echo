// --- COLORS FOR #272C3B THEME ---
var col_bg      = make_color_rgb(39, 44, 59);    // #272C3B
var col_border  = make_color_rgb(27, 31, 42);    // #1B1F2A
var col_grid    = make_color_rgb(58, 65, 87);    // Subtle lighter slate
var col_target  = make_color_rgb(255, 82, 82);   // Bright Coral Red (#FF5252)
var col_start   = c_aqua;                        // High-contrast Aqua
var col_match   = make_color_rgb(77, 255, 136);  // Bright Mint Green (#4DFF88)

// --- DRAW PANEL BACKGROUND & BORDER ---
var pad_x = 40;
var pad_y = 270;
var box_x1 = wave_center_x - pad_x;
var box_y1 = wave_center_y - pad_y;
var box_x2 = wave_center_x + wave_length + pad_x;
var box_y2 = wave_center_y + pad_y;
var border_thickness = 6;

// Outer Border (#1B1F2A)
draw_set_color(col_border);
draw_rectangle(box_x1 - border_thickness, box_y1 - border_thickness, box_x2 + border_thickness, box_y2 + border_thickness, false);

// Inner Background (#272C3B)
draw_set_color(col_bg);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);

// --- DRAW WAVE FUNCTION (GUI LAYER) ---
// 1. Draw Center Line
draw_set_color(col_grid);
draw_line_width(wave_center_x, wave_center_y, wave_center_x + wave_length, wave_center_y, 2);

// 2. Draw Target Wave (Distorted & Flickering when frequency is off)
var distortion = (1 - freq_clarity) * 26; // Up to 26px of vertical static jitter
var flicker_alpha = lerp(random_range(0.15, 0.55), 1.0, freq_clarity);

// Occasional signal dropout flicker when far from correct frequency
if (!is_completed && freq_clarity < 0.75 && random(1) < (1 - freq_clarity) * 0.25) {
    flicker_alpha *= 0.2;
}

draw_set_alpha(flicker_alpha);
draw_set_color(col_target);

var step_px = 4;
var prev_y = wave_center_y + sin(wave_phase + t) * target_amp + random_range(-distortion, distortion);

for (var xx = step_px; xx <= wave_length; xx += step_px) {
    var noise = is_completed ? 0 : random_range(-distortion, distortion);
    var curr_y = wave_center_y + sin((xx * target_freq) + wave_phase + t) * target_amp + noise;
    
    draw_line_width(wave_center_x + xx - step_px, prev_y, wave_center_x + xx, curr_y, 3);
    prev_y = curr_y;
}
draw_set_alpha(1.0); // Reset alpha

// 3. Draw Player Wave (Aqua -> Mint Green based on accuracy)
var player_color = merge_color(col_start, col_match, sync_accuracy / 100);
draw_set_color(player_color);

for (var xx = 0; xx < wave_length; xx += step_px) {
    var y1 = wave_center_y + sin((xx * player_freq) + wave_phase + t) * player_amp;
    var y2 = wave_center_y + sin(((xx + step_px) * player_freq) + wave_phase + t) * player_amp;
    
    draw_line_width(wave_center_x + xx, y1, wave_center_x + xx + step_px, y2, 3);
}

// --- DRAW HUD & METRICS ---
draw_set_font(-1); 
draw_set_color(c_white);

// Title & Instructions
draw_text(wave_center_x, wave_center_y - 240, "SIGNAL SYNCHRONIZER");
draw_set_color(c_ltgray);
draw_text(wave_center_x, wave_center_y - 210, "Controls: W/S (Amplitude) | A/D (Stabilize Frequency)");

// Timer Display
var timer_color = (time_left <= 2.5) ? col_target : c_yellow;
draw_set_color(timer_color);
if (!is_completed && !is_failed) {
    draw_text(wave_center_x + wave_length - 110, wave_center_y - 240, "TIME: " + string_format(time_left, 1, 1) + "s");
}

// Match Progress Bar
var bar_width = 400;
var bar_height = 18;
var bar_x = wave_center_x + (wave_length / 2) - (bar_width / 2);
var bar_y = wave_center_y + 205;

draw_set_color(col_border);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

draw_set_color(player_color);
draw_rectangle(bar_x, bar_y, bar_x + (bar_width * (sync_accuracy / 100)), bar_y + bar_height, false);

draw_set_color(col_grid);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);

draw_set_color(c_white);
draw_text(bar_x, bar_y + 26, "SYNC: " + string(round(sync_accuracy)) + "%");
draw_text(bar_x + 250, bar_y + 26, "CLARITY: " + string(round(freq_clarity * 100)) + "%");

// Status Messages (Centered)
if (is_completed || is_failed) {
    var center_x = wave_center_x + (wave_length / 2);
    var box_half_w = 220;
    var box_half_h = 35;

    draw_set_color(col_border);
    draw_rectangle(center_x - box_half_w, wave_center_y - box_half_h, center_x + box_half_w, wave_center_y + box_half_h, false);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (is_completed) {
        draw_set_color(col_match);
        draw_text_transformed(center_x, wave_center_y, "SIGNAL LOCKED!", 2, 2, 0);
    } else if (is_failed) {
        draw_set_color(col_target);
        draw_text_transformed(center_x, wave_center_y, "SIGNAL LOST!", 2, 2, 0);
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}