// --- SINGLETON CHECK ---
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

// --- DISPLAY CONFIGURATION ---
display_set_gui_size(1366, 768);

// --- WAVE PARAMETERS (Amplitude + Drifting Frequency) ---
target_amp  = irandom_range(55, 130);       // Random target amplitude
target_freq = random_range(0.035, 0.085);   // Random target frequency

player_amp  = 30;
player_freq = 0.02;
wave_phase  = 0;

wave_center_x = 200;
wave_center_y = 384;   
wave_length   = 966;   
wave_speed    = 0.05;


time_limit   = 8.0;  
time_left    = time_limit;

sync_accuracy = 0;
freq_clarity  = 0;    
is_completed  = false;
is_failed     = false;

result_timer  = 3.0;   


t = 0;
drift_timer = 0;
drift_dir = choose(-1, 1);


amp_speed        = 2.5;
freq_speed       = 0.0008;
freq_drift_speed = 0.00028; 