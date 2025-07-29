shader_type spatial;
render_mode diffuse_toon;

uniform sampler2D text: source_color;
uniform float edge_power = 1.0;
uniform sampler2D displasment_noise;

void fragment() {

	vec4 displasment_text = texture(displasment_noise, (UV * 2.0) + TIME * 0.01);
	vec2 displasment_gray = vec2(0.1,0.1) * displasment_text.r;
	vec2 displasment_white = vec2(-0.1,-0.1) * displasment_text.r;

	vec4 _text = texture(text, UV + (TIME * 0.1) - (displasment_gray - displasment_white));
	ALBEDO = _text.rgb + vec3(0.0, 0.55, 0.5);
	METALLIC = 1.0;
	ROUGHNESS = 1.0;
	EMISSION = _text.rgb * 0.1;
	// Fresnel
	float fresnel = dot(NORMAL, VIEW);
	ALPHA = pow(fresnel, edge_power);
}
