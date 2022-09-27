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




Player.gryo_data = undefined;
var slot = 0; repeat (array_length(slotdata)) {
	var data = slotdata[@ slot];
	//{
	if (!is_undefined(data)) {
        Player.gyro_data = data;
	}
    
	//}
	++slot;
}