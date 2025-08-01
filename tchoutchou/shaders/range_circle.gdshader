shader_type canvas_item;

uniform float size = 1000.0;
uniform float circle_thickness = 10.0;
uniform float rays = 8.0;
uniform float fill_alpha = 0.5;
uniform float circle_alpha = 0.75;
uniform float animation_speed = 0.5;

instance uniform float radius = 100.0;
instance uniform vec3 fill_color : source_color = vec3(1.0);

void fragment() {
	vec2 polar_uv = vec2(
		length(UV * 2.0 - vec2(1.0)),
		(atan(UV.y - 0.5, UV.x - 0.5) + PI) / (2.0 * PI)
	);

	float circle_fade = step((radius - circle_thickness) / size, polar_uv.x);
	float radial_fade = step(0.5, fract(polar_uv.y * rays + TIME * animation_speed));
	float fill_fade = step(radius / size, polar_uv.x);

	vec4 color = vec4(fill_color, mix(fill_alpha, circle_alpha, circle_fade * radial_fade));
	color.a = mix(color.a, 0.0, fill_fade);

	COLOR = color;
}
