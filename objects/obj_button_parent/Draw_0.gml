//shader_set(shd_button);
// Send uniform variables
var u_time = shader_get_uniform(shd_button, "time");
shader_set_uniform_f(u_time, time);

var u_alpha = shader_get_uniform(shd_button, "alpha");
shader_set_uniform_f(u_alpha, image_alpha);
draw_self();
shader_reset();

// --- Draw Button Text ---
draw_set_font(fnt_menu_40);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, button_text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
