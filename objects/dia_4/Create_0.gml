// --- SINGLETON CHECK ---
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

// --- DISPLAY CONFIGURATION ---
display_set_gui_size(1366, 768);

// --- WAVE PARAMETERS (Amplitude Match Only) ---
target_amp = irandom_range(50, 130); // Random target amplitude per round
player_amp = 30;                     // Initial player amplitude

// Fixed frequency and phase so waves align horizontally
wave_freq = 0.05;
wave_phase = 0;

// Wave Position on Screen (Centered for 1366x768)
wave_center_x = 200;
wave_center_y = 384;   // 768 / 2
wave_length = 966;     // 1366 - 400 margins
wave_speed = 0.05;     // Oscillation over time

// --- GAME LOGIC & TIMERS ---
time_limit = 5.0;      // 5 seconds total gameplay time
time_left = time_limit;

sync_accuracy = 0;
is_completed = false;
is_failed = false;

result_timer = 3.0;    // 3-second delay after getting the result before destroying itself

// Time counter for wave animation
t = 0;

// Adjustment Speed
amp_speed = 2.5;