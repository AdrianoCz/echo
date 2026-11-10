// --- DRAW WAVE FUNCTION (GUI LAYER) ---
// 1. Draw Center Line
draw_set_color(c_dkgray);
draw_line(wave_center_x, wave_center_y, wave_center_x + wave_length, wave_center_y);

// 2. Draw Target Wave (Red Line)
draw_set_color(c_red);
var step_px = 4;
for (var xx = 0; xx < wave_length; xx += step_px) {
    var y1 = wave_center_y + sin((xx * wave_freq) + wave_phase + t) * target_amp;
    var y2 = wave_center_y + sin(((xx + step_px) * wave_freq) + wave_phase + t) * target_amp;
    
    draw_line_width(wave_center_x + xx, y1, wave_center_x + xx + step_px, y2, 3);
}

// 3. Draw Player Wave (Orange -> Lime based on accuracy)
var player_color = merge_color(c_orange, c_lime, sync_accuracy / 100);
draw_set_color(player_color);

for (var xx = 0; xx < wave_length; xx += step_px) {
    var y1 = wave_center_y + sin((xx * wave_freq) + wave_phase + t) * player_amp;
    var y2 = wave_center_y + sin(((xx + step_px) * wave_freq) + wave_phase + t) * player_amp;
    
    draw_line_width(wave_center_x + xx, y1, wave_center_x + xx + step_px, y2, 2);
}

// --- DRAW HUD & METRICS ---
draw_set_font(-1); 
draw_set_color(c_white);

// Title & Instructions
draw_text(wave_center_x, wave_center_y - 240, "AMPLITUDE SYNCHRONIZER");
draw_text(wave_center_x, wave_center_y - 210, "Controls: UP / DOWN (or W / S) to match wave height!");

// Timer Display (Turns red when under 2 seconds)
var timer_color = (time_left <= 2.0) ? c_red : c_yellow;
draw_set_color(timer_color);
if (!is_completed && !is_failed) {
    draw_text(wave_center_x + wave_length - 150, wave_center_y - 240, "TIME: " + string_format(time_left, 1, 1) + "s");
}

// Match Progress Bar (Centered relative to the wave width)
var bar_width = 400;
var bar_height = 18;
var bar_x = wave_center_x + (wave_length / 2) - (bar_width / 2);
var bar_y = wave_center_y + 220;

draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);

draw_set_color(player_color);
draw_rectangle(bar_x, bar_y, bar_x + (bar_width * (sync_accuracy / 100)), bar_y + bar_height, false);

draw_set_color(c_white);
draw_text(bar_x, bar_y + 28, "ACCURACY: " + string(round(sync_accuracy)) + "%");

// Status Messages
if (is_completed) {
    draw_set_color(c_lime);
    draw_text_transformed(bar_x + 60, wave_center_y - 30, "AMPLITUDE MATCHED!", 2, 2, 0);
} else if (is_failed) {
    draw_set_color(c_red);
    draw_text_transformed(bar_x + 100, wave_center_y - 30, "TIME UP!", 2, 2, 0);
}