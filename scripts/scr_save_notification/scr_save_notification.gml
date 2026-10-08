function save_notification_show() {
    if (!instance_exists(save_notification)) {
        instance_create_layer(0, 0, "Instances", save_notification);
    }
    

    with (save_notification) {
        state = "fade_in";
        timer = 0;
    }
}
