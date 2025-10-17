/// Enemy Step Event

var player = instance_nearest(x, y, obj_player);
var detect_range = 200;
var shoot_cooldown_max = 30; // frames between shots

// Initialize shoot cooldown if not set
if (!variable_instance_exists(self, "shoot_cooldown")) {
    shoot_cooldown = 0;
}

if (player != noone) {
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < detect_range) {
        // Player is in range → shoot
        sprite_index = spr_enemy_shoot;
        image_speed = 0.3;

        if (hspeed != 0) { 
            pre_hspeed = hspeed;
        }

        hspeed = 0; // stop moving while shooting

        // --- Shoot bullets ---
        if (shoot_cooldown <= 0) {
			
            var b = instance_create_layer(x, y, "Instances", obj_enemy_bullet);
            b.direction = point_direction(x, y, player.x, player.y);
            b.speed = 6;

            shoot_cooldown = shoot_cooldown_max;
        } else {
            shoot_cooldown--;
        }
    } else {
        // Player out of range → keep walking via marker
        sprite_index = spr_enemy_walk;
        image_speed = 0.2;

        if (hspeed == 0) { 
            hspeed = pre_hspeed;    
        }
    }
}

// Reduce cooldown just in case
if (shoot_cooldown > 0) {
    shoot_cooldown--;
}
