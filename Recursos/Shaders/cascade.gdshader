shader_type spatial;

uniform sampler2D text: source_color;
uniform sampler2D displasment_noise;

void fragment() {
	vec4 displasment_text = texture(displasment_noise, (UV * 2.0) - vec2(0.0, TIME * 1.0) );
	vec2 displasment_gray = vec2(0.29,0.29) * displasment_text.r;
	vec2 displasment_white = vec2(-0.29,-0.29) * displasment_text.r;

	vec4 _text = texture(text, (UV + vec2(0.0, -TIME* 0.1) ) + (displasment_gray - displasment_white));
	ALBEDO = _text.rgb;
	ALPHA = 0.25;
	// Called for every pixel the material is visible on.
}
