// Time variable for smooth motion
var time = current_time / 10; // Divide to slow down oscillation

// Smooth vertical hover
y = base_y + sin(time * hover_speed) * hover_amplitude;

// Smooth rotation hover
image_angle = base_angle + sin(time * rotation_speed) * rotation_amplitude;
