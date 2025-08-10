shader_type spatial;
render_mode shadows_disabled;

uniform sampler2D albedo_color: source_color;
uniform sampler2D shadow_mask;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 text = texture(albedo_color,UV);
	ALBEDO = text.rgb;
	ALPHA = text.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
