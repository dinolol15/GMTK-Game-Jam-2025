shader_type canvas_item;

uniform sampler2D big_noise;
uniform sampler2D small_noise;
uniform float period = 0.01;

void fragment() {
	COLOR = mix(texture(big_noise, UV), texture(small_noise, fract(UV / period)), 0.5);
}
