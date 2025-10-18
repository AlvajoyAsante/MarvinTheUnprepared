// --- BASIC SETUP ---
var on_ground = place_meeting(x, y + 1, obj_block);
var gravity_force = 0.25;
var moving = false;


// --- SPEED + STAMINA ---
var sprint_speed = base_speed + 5;
var stamina_drain = 0.1;
var stamina_regen = 0.2;

if (!attacking && !crouching) {
	
	// --- SPRINTING ---
	var current_speed = base_speed;
	if (keyboard_check(vk_shift) && global.stamina  > 0) {
	    current_speed = sprint_speed;
	    global.stamina -= stamina_drain;
	} else {
	    global.stamina = clamp(global.stamina + stamina_regen, 0, global.max_stamina);
	}


	// --- HORIZONTAL MOVEMENT ---
	if (keyboard_check(vk_left) && !place_meeting(x - current_speed, y, obj_block)) {
	    if (image_xscale > 0) image_xscale *= -1;
	    x -= current_speed;
	    moving = true;
	}
	if (keyboard_check(vk_right) && !place_meeting(x + current_speed, y, obj_block)) {
	    if (image_xscale < 0) image_xscale *= -1;
	    x += current_speed;
	    moving = true;
	}
	
	// --- FOOTSTEP SOUND CONTROL ---
	if (on_ground && moving) {
	    // If sound isn't already playing, start it
	    if (!audio_is_playing(su_marvin_footsteps)) {
	        var snd = audio_play_sound(su_marvin_footsteps, 1, true);
			audio_sound_pitch(snd, 1.4);
	    }
	} else {
	    // Stop footsteps when not moving on the ground
	    if (audio_is_playing(su_marvin_footsteps)) {
	        audio_stop_sound(su_marvin_footsteps);
	    }
	}
	
	
	// --- JUMP & DOUBLE JUMP ---
	if (keyboard_check_pressed(vk_up)) {
	    if (on_ground) {
	        vspeed = -jump_height;
	        can_double_jump = true;
			part_particles_create(global.p_sys, x, y + sprite_height / 2, p_type_jump_flash, 8);
	    } else if (can_double_jump) {
	        vspeed = -jump_height * 0.9;
	        can_double_jump = false;
			part_particles_create(global.p_sys, x, y, p_type_jump_flash, 15);
	    }
		
		audio_play_sound(su_marvin_jump, 0, false);
	}

	// --- DASH ---
	if (dash_timer > 0) dash_timer -= 1;

	if (keyboard_check_pressed(vk_space) && dash_timer <= 0) {
	    var dash_dir = sign(image_xscale);
	    x += dash_dir * dash_speed;
	    dash_timer = dash_cooldown;
	    show_debug_message("Dash!");
	}

}

// --- GRAVITY ---
if (!on_ground) vspeed += gravity_force;

// --- APPLY VERTICAL MOVEMENT ---
y += vspeed;

// --- COLLISION FIX ---
if (place_meeting(x, y+base_speed -1 , obj_block) || place_meeting(x, y-base_speed+1, obj_block)) {
    if (vspeed > 0) {
        while (!place_meeting(x, y + 1, obj_block)) y += .1;
    } else if (vspeed < 0) {
        while (!place_meeting(x, y - 1, obj_block)) y -= .1;
    }
    vspeed = 0;
}


// --- CROUCH / FAST FALL ---
if (keyboard_check(vk_down)) {
	if (on_ground && !moving && !crouching) {
		show_debug_message("Crouch!");
		crouching = true;
		image_index = 0;
	} else {
		vspeed += gravity_force * 1.5; // fast fall
	}
}
	
if (crouching && on_ground) {
	if (!keyboard_check(vk_down)) {
		if (image_index >= image_number - 1) { 
			crouching = false;
			show_debug_message("Crouch Finished!");
		}	 
	}
}

// --- ATTACK ---
if (keyboard_check_pressed(ord("X")) && !attacking && on_ground) {
    attacking = true;
    sprite_index = spr_marvin_attack;
    image_speed = 1;
    image_index = 0;
	
}

// End attack when animation finishes
if (attacking) {
    if (image_index >= image_number - 1) {
        attacking = false;
    }
}


// --- ANIMATION CONTROL ---
if (!attacking) {
    if (!on_ground) {
        if (vspeed < 0) {
            // Jumping
            sprite_index = spr_marvin_jump;
            image_speed = 1;
            if (image_index >= image_number - 1) image_index = image_number - 1; // stop on last jump frame
        } else {
            // Falling
            sprite_index = spr_marvin_fall;
            image_speed = 1;
            if (image_index >= image_number - 1) image_index = image_number - 1; // stop on last fall frame
        }
    } else if (moving) {
        sprite_index = spr_marvin_walk;
        image_speed = 1;
	} else if (crouching) { 
		sprite_index = spr_marvin_crouch;
		 image_speed = 1;
		if (image_index >= image_number - 1) image_index = image_number - 1; 
    } else {
        sprite_index = spr_marvin_idle;
        image_speed = 1;
    }
} 

// Feel off room
if (y > room_height + 100) {
	// remove health and restart level	
	health -= 1;
	instance_deactivate_object(self)
	room_restart()
}

if (flash_strength > 0) {
    flash_strength = max(0, flash_strength - 0.2);
}

if (global.shards == 3) {
	room_goto(rm_ship_fix)
}

if (keyboard_check(vk_f1)) {
	global.shards = 3;
}