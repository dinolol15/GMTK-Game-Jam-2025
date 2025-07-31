shader_type canvas_item;

uniform vec4 color_1 : source_color = vec4(1.0);
uniform vec4 color_2 : source_color = vec4(1.0);
uniform vec2 scale = vec2(1.0);

instance uniform float rope_length = 1.0;

void fragment() {
	float color_fade = step(0.5, fract(UV.x * scale.x * rope_length + UV.y * scale.y));
	COLOR = mix(color_1, color_2, color_fade);
}
