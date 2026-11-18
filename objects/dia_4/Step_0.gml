// --- POST-RESULT DESTRUCTION TIMER ---
obj_player.is_paused = true;
if (is_completed || is_failed) {
    result_timer -= 1 / room_speed;

    if (result_timer <= 0) {
        instance_destroy();
	obj_player.is_paused = false;
    }
    exit;
}

// --- GAMEPLAY TIMER COUNTDOWN ---
time_left -= 1 / room_speed;
if (time_left <= 0) {
    time_left = 0;
    is_failed = true;
    show_debug_message("MINIGAME FAILED: TIME OUT");
	change_sanity(-25);
    exit;
}

t += wave_speed;

// --- FREQUENCY DRIFT (Fights against the player) ---
drift_timer--;
if (drift_timer <= 0) {
    // Periodically switch drift direction to keep player on their toes
    drift_dir = choose(-1, 1);
    drift_timer = irandom_range(35, 80);
}
player_freq += drift_dir * freq_drift_speed;

// --- PLAYER CONTROLS ---
// Amplitude: UP / DOWN or W / S
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    player_amp = min(150, player_amp + amp_speed);
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    player_amp = max(10, player_amp - amp_speed);
}

// Frequency: LEFT / RIGHT or A / D
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    player_freq -= freq_speed;
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    player_freq += freq_speed;
}
player_freq = clamp(player_freq, 0.015, 0.11);

// --- ACCURACY & CLARITY CALCULATION ---
var amp_diff  = abs(target_amp - player_amp);
var freq_diff = abs(target_freq - player_freq);

// Clarity ranges from 0 (very distorted) to 1 (clear) based on frequency match
freq_clarity = clamp(1 - (freq_diff / 0.035), 0, 1);

// Combined accuracy score (50% amplitude, 50% frequency)
var amp_score  = clamp(100 - ((amp_diff / 120) * 100), 0, 100);
var freq_score = freq_clarity * 100;
sync_accuracy  = (amp_score * 0.5) + (freq_score * 0.5);

// --- WIN CONDITION CHECK ---
// Win when amplitude is within 8px AND frequency is within 0.0035
if (amp_diff <= 8 && freq_diff <= 0.0035) {
    freq_clarity = 1;
    sync_accuracy = 100;
    is_completed = true;
	
    show_debug_message("MINIGAME CLEARED!");
}