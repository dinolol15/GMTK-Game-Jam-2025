shader_type canvas_item;

uniform vec4 color_1 : source_color = vec4(1.0);
uniform vec4 color_2 : source_color = vec4(1.0);
uniform float scale_x = 0.1;

instance uniform float rope_length = 10.0;

void fragment() {
	float color_fade = step(0.5, fract(UV.x * rope_length * scale_x));
	COLOR = mix(color_1, color_2, color_fade);
}
