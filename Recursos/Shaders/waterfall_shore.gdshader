shader_type spatial;

uniform sampler2D text: source_color;
uniform float radius = 0.5;

void fragment() {
	vec4 _text = texture(text, UV + vec2(0.0,TIME* 0.6));
	ALBEDO = _text.rgb + vec3(0.0, 0.55, 0.45);
	METALLIC = 0.5;
	// alpha circle
	vec2 uv_centered = UV - vec2(0.5, 0.5);
	float distance_from_center = length(uv_centered);
	float normalize_distance = distance_from_center / radius;

	float alpha = 1.0 - smoothstep(0.0, 1.0, normalize_distance);
	ALPHA = alpha;

}

