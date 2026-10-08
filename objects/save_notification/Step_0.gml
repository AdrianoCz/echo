switch (state) {
    case "idle":
        alpha = 0;
        break;
        
    case "fade_in":
        timer += 1;
        alpha = timer / fade_in_time;
        if (timer >= fade_in_time) {
            alpha = 1;
            timer = 0;
            state = "stay";
        }
        break;
        
    case "stay":
        timer += 1;
        if (timer >= stay_time) {
            timer = 0;
            state = "fade_out";
        }
        break;
        
    case "fade_out":
        timer += 1;
        alpha = 1 - (timer / fade_out_time);
        if (timer >= fade_out_time) {
            alpha = 0;
            state = "idle";
        }
        break;
}