/// @description Poke.

timer = get_timer();

if (serverId != -1) {
	pollAllData();
	clobberSlots();
	
	// check if we had no network events in a long time
	if (timer - lastGotTime > emergencyMargin) {
		window_set_caption("LOST CONNECTION TO SERVER! DID NOT RECEIVE ANY EVENTS FOR A LONG TIME");
		serverId = -1; resetSlots();
		//uncomment this if you also wish to reset the underlying socket:
		//client.reset();
		//this is usually not needed
		// enter a reconnection state...
	}
	else {
		window_set_caption("All is fine");
	}
}
else {
	if (timer - lastGotTime > connectionMargin) {
		lastGotTime = timer;
		client.getVersionReq();
		show_debug_message("Attempting reconnection...");
	}
}



/// @description Insert description here
// You can write your code in this editor

if (serverId == -1) {
	draw_text(64, 64, "no server bound yet...");
	exit;
}




var slot = 0; repeat (array_length(slotdata)) {
	var data = slotdata[@ slot];
	//{
	if (!is_undefined(data)) {
//x += delta_time/1000000 *  data.angVelYaw   * 11;
//y += delta_time/1000000 * -data.angVelPitch * 11 * window_get_height()/window_get_width();

//steam
//x += (delta_time/1000000) * -data.rot_vel_z * 0.642;
//y += (delta_time/1000000) * -data.rot_vel_x * 0.642 * window_get_height()/window_get_width();
        var dt = delta_time / 1000000;
        var s = 0.01 * window_get_width();          // 0.0628 rads per pixel of width
        var aspect = window_get_height() / window_get_width();

        x += dt *  data.angVelYaw * s;
        y += dt * -data.angVelPitch * s * aspect;
	}
	//}
	++slot;
}

if (keyboard_check(vk_f1)) {
    var w = 854;
    var h = 480;
    window_set_size(w, h);
    surface_resize(application_surface, w, h);
    x = w / 2;
    y = h / 2;
    camera_set_view_size(cam, w, h);
}

if (keyboard_check(vk_f2)) {
    var w = 1280;
    var h = 720;
    window_set_size(w, h);
    surface_resize(application_surface, w, h);
    x = w / 2;
    y = h / 2;
    camera_set_view_size(cam, w, h);
}

if (keyboard_check(vk_f3)) {
    var w = 1600;
    var h = 900;
    window_set_size(w, h);
    surface_resize(application_surface, w, h);
    x = w / 2;
    y = h / 2;
    camera_set_view_size(cam, w, h);
}