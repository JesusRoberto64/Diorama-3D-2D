shader_type spatial;

uniform sampler2D text: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.z -= cos(TIME * 3.0);
}

void fragment() {
	float mov = -TIME * 0.1;
	vec4 _text = texture(text, UV + vec2(mov, 0.0));
	ALBEDO = _text.rgb;
	ALPHA = 0.23;
}
