// --- POST-RESULT DESTRUCTION TIMER ---
if (is_completed || is_failed) {
    result_timer -= 1 / room_speed;
    if (result_timer <= 0) {
		obj_player.is_paused = false;
        instance_destroy(); // Clears the minigame object after 3 seconds
    }
    exit;
}
obj_player.is_paused = true;
// --- GAMEPLAY TIMER COUNTDOWN ---
time_left -= 1 / room_speed;
if (time_left <= 0) {
    time_left = 0;
    is_failed = true;
    show_debug_message("MINIGAME FAILED: TIME OUT");
    exit;
}

t += wave_speed;

// --- CONTROLS (Amplitude Only) ---
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    player_amp = min(150, player_amp + amp_speed);
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    player_amp = max(10, player_amp - amp_speed);
}

// --- ACCURACY CALCULATION ---
var diff = abs(target_amp - player_amp);
var max_diff = 140;
sync_accuracy = clamp(100 - ((diff / max_diff) * 100), 0, 100);

// --- WIN CONDITION CHECK ---
// Win if amplitude is within 7 pixels of target
if (diff <= 7) {
    is_completed = true;
    show_debug_message("MINIGAME CLEARED!");
}