shader_type canvas_item;

uniform vec4 fill_color : source_color = vec4(1.0);
uniform float circle_thickness : hint_range(0.0, 1.0) = 0.4;

instance uniform float progress : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 polar_uv = vec2(
		length(UV * 2.0 - vec2(1.0)),
		(atan(UV.y - 0.5, UV.x - 0.5) + PI) / (2.0 * PI)
	);

	float wrapped_angle = polar_uv.y - 0.25;
	if (wrapped_angle < 0.0) {
		wrapped_angle += 1.0;
	}

	float inner_fade = step(1.0 - circle_thickness, polar_uv.x);
	float outer_fade = step(polar_uv.x, 1.0);
	float progress_fade = step(wrapped_angle, progress);

	COLOR = fill_color * inner_fade * outer_fade * progress_fade;
}
