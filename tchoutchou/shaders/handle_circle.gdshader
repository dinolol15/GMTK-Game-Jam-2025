shader_type canvas_item;

uniform vec3 fill_color : source_color = vec3(1.0);
uniform float radius : hint_range(0.0, 1.0) = 0.5;
uniform float thickness : hint_range(0.0, 1.0) = 0.2;

void fragment() {
	float radial_distance = length(UV * 2.0 - vec2(1.0));
	float inner_fade = step(radius - thickness / 2.0, radial_distance);
	float outer_fade = step(radial_distance, radius + thickness / 2.0);

	COLOR = vec4(fill_color, inner_fade * outer_fade);
}
