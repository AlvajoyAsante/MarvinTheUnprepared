/// Collision Event: Player hit by enemy bullet
global.health -= 1;
flash_strength = 1.0; // flash red on being hit
instance_destroy(other); // remove bullet after impact

show_debug_message("Player hit by bullet! Health: " + string(global.health));

// Check if player is dead
if (global.health <= 0) {
	global.health = 0;
	show_debug_message("Player defeated!");
	room_restart(); // Restart level on death
}
