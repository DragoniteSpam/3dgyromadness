/// @description Insert description here

if (mouse_lock) {
    #region regular movement
    if (gyro_data) {
        var dt = delta_time / 1000000;
        var s = 0.0025 * window_get_width();          // 0.0628 rads per pixel of width
        var aspect = window_get_height() / window_get_width();
        var inverty = -1;
        
        look_dir -=     dt * gyro_data.angVelYaw * s;
        look_pitch -=   dt * gyro_data.angVelPitch * s * inverty;
    }
    look_dir -= (window_mouse_get_x() - window_get_width() / 2) / 10;
    look_pitch -= (window_mouse_get_y() - window_get_height() / 2) / 10;
    look_pitch = clamp(look_pitch, -85, 85);
    
    window_mouse_set(window_get_width() / 2, window_get_height() / 2);

    if (keyboard_check_direct(vk_escape)) {
        game_end();
    }

    var move_speed = 4;
    var dx = 0;
    var dy = 0;

    if (keyboard_check(ord("A"))) {
        dx += dsin(look_dir) * move_speed;
        dy += dcos(look_dir) * move_speed;
    }

    if (keyboard_check(ord("D"))) {
        dx -= dsin(look_dir) * move_speed;
        dy -= dcos(look_dir) * move_speed;
    }

    if (keyboard_check(ord("W"))) {
        dx -= dcos(look_dir) * move_speed;
        dy += dsin(look_dir) * move_speed;
    }

    if (keyboard_check(ord("S"))) {
        dx += dcos(look_dir) * move_speed;
        dy -= dsin(look_dir) * move_speed;
    }
    
    x += dx;
    y += dy;
    #endregion
}

if (keyboard_check_pressed(vk_tab)) {
    mouse_lock = !mouse_lock;
}