hspeed=hsp;
health=3;
knockback=4;
attack_range=15;
attack_rate=60;
attack_cooldown=0;
/// Enemy Create Event
range = 250; // Distance to detect player
 // Frames between bullets (~0.66 sec at 60 fps)
pre_hspeed = hspeed

flash_strength = 0;
flash_decay = 0.2;

// Set the attack_cooldown to start the shooting cycle
shoot_cooldown = attack_rate;

// Create and configure the Particle Type for GUN SMOKE
p_type_smoke = part_type_create();
part_type_shape(p_type_smoke, pt_shape_square);
part_type_size(p_type_smoke, 0.1, 0.4, 0, 0);
part_type_life(p_type_smoke, 10, 15);
part_type_speed(p_type_smoke, 0.5, 1, 0, 0);
part_type_direction(p_type_smoke, 90, 90, 0, 0); // Moves straight up
part_type_alpha3(p_type_smoke, 0.5, 0.2, 0); // Fades quickly
part_type_color1(p_type_smoke, c_gray);


// Create and configure the Particle Type for DEATH EXPLOSION
p_type_explosion = part_type_create();
part_type_shape(p_type_explosion, pt_shape_star);
part_type_size(p_type_explosion, 0.3, 0.8, -0.02, 0); // Shrinks slowly
part_type_life(p_type_explosion, 30, 60);
part_type_speed(p_type_explosion, 2, 4, -0.05, 0); // Starts fast, slows down
part_type_alpha3(p_type_explosion, 1, 0.5, 0); // Spreads everywhere
part_type_color2(p_type_explosion, c_red, c_yellow); // Red/Yellow debris (mixes colors)