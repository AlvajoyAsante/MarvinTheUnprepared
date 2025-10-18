// Get player reference
var _player = obj_player;

if (!instance_exists(_player)) exit;

// Screen positions for bars
var _bar_x = (display_get_gui_width() - sprite_get_width(spr_health_bar)) / 2;
var _bar_y = 500;

// --- HEALTH BAR ---
draw_sprite(spr_health_bar, global.health, _bar_x, _bar_y);

// --- STAMINA BAR ---
draw_sprite(spr_stamina_bar, floor(global.stamina), _bar_x, _bar_y); // slightly below health


//draw_set_color(c_white);
draw_set_font(-1); 
draw_text(10, 10, "GUI Width: " + string(display_get_gui_width()));
draw_text(10, 30, "GUI Height: " + string(display_get_gui_height()));
draw_text(10, 50, "Stamina: " + string(global.stamina));