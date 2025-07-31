shader_type canvas_item;

const float SIZE = 1000.0;
const float CIRCLE_THICKNESS = 10.0;
const float RAYS = 8.0;
const float FILL_ALPHA = 0.5;
const float CIRCLE_ALPHA = 0.75;
const float ANIMATION_SPEED = 0.5;

uniform float radius = 100.0;
uniform vec3 fill_color : source_color = vec3(1.0);


void fragment() {
	vec2 polar_uv = vec2(
		length(UV * 2.0 - vec2(1.0)),
		(atan(UV.y - 0.5, UV.x - 0.5) + PI) / (2.0 * PI)
	);

	float circle_fade = step((radius - CIRCLE_THICKNESS) / SIZE, polar_uv.x);
	float radial_fade = step(0.5, fract(polar_uv.y * RAYS + TIME * ANIMATION_SPEED));
	float fill_fade = step(radius / SIZE, polar_uv.x);

	vec4 color = vec4(fill_color, mix(FILL_ALPHA, CIRCLE_ALPHA, circle_fade * radial_fade));
	color.a = mix(color.a, 0.0, fill_fade);

	COLOR = color;
}
