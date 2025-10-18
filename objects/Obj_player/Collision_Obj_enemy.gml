

/// Collision Event: Player with Enemy

// --- Initialize enemy damage cooldown if not exists ---
if (!variable_instance_exists(other, "damage_cooldown")) {
    other.damage_cooldown = 0;
}

// --- Player takes damage from touching enemy ---
// Only take damage if cooldown has expired (avoid taking damage every frame)
if (other.damage_cooldown <= 0 && !attacking) {
    global.health -= 1;
    flash_strength = 1.0; // flash red on being hit
    other.damage_cooldown = 60; // 60 frames (~1 second) cooldown before damage again
    
    show_debug_message("Player hit by enemy! Health: " + string(global.health));
    
    // Knockback player away from enemy
    var knockback_dir = sign(x - other.x);
    x += knockback_dir * 20;
    vspeed = -5; // bounce upward
    
    // Check if player is dead
    if (global.health <= 0) {
        global.health = 0;
        show_debug_message("Player defeated by enemy!");
        room_restart(); // Restart level on death
    }
}

// --- Player attacks enemy with X key ---
if (keyboard_check_pressed(ord("X"))) {

    // Ensure the enemy has health variable
    if (!variable_instance_exists(other, "health")) {
        other.health = 3; 
        other.knockback = 4; 
    }

    // Reduce enemy health
    other.health -= 1;

    // Flash red for a few frames
	other.image_blend = c_red;
    other.alarm[0] = 5;
    other.flash_strength = 1.0;

    // Knockback enemy slightly
    other.x += other.x < x ? -other.knockback : other.knockback;

    // Destroy enemy if health <= 0
    if (other.health <= 0) {
        if (global.p_sys > -1) {
        part_particles_create(global.p_sys, other.x, other.y, other.p_type_explosion, 15);
       }
        instance_destroy(other);
    }
}

// --- Player jumps on enemy (stomp attack) ---
if (vspeed > 0 && bbox_bottom <= other.bbox_top + 5) {
	if (!variable_instance_exists(other, "health")) {
        other.health = 3;
    }
    other.health -= 1;
    other.flash_strength = 1.0; // flash on stomp
    vspeed = -6; // bounce upward slightly

    if (other.health <= 0) {
		if (global.p_sys > -1) {
            part_particles_create(global.p_sys, other.x, other.y, other.p_type_explosion, 15);
        }
        instance_destroy(other);
    }
}

// --- Enemy damages player (if player isn't attacking) ---
if (!keyboard_check_pressed(ord("X")) && vspeed <= 0) {
    health -= 1;
    flash_strength = 1.0; // flash red on player
    show_debug_message("Player hit!");
}

