shader_type spatial;

uniform sampler2D displasmet_noise;
uniform sampler2D albedo_text: source_color;

void fragment() {
	// Displacemente in white and gray
	vec4 displasment_text = texture(displasmet_noise, UV + TIME * 0.5);
	vec2 displasment_gray = vec2(0.02,0.02) * displasment_text.r;
	vec2 displasment_white = vec2(-0.02,-0.02) * displasment_text.r;

	vec4 text = texture(albedo_text, UV + (displasment_gray - displasment_white));


	ALBEDO = text.rgb;
}
