shader_type spatial;


uniform sampler2D albedo_texture : source_color;
uniform sampler2D normalmap;

void fragment() {
	NORMAL_MAP = texture(normalmap, (UV*5.0) - (TIME * 0.05)).xyz;
	ROUGHNESS = 0.2;

	vec4 displasment_text = texture(normalmap, (UV) - TIME * 0.05);
	vec2 displacement_x = displasment_text.x * vec2(2.01, 2.01);
	vec2 displacement_y = displasment_text.x * vec2(-2.01, -2.01);

	vec4 tex_color = texture(albedo_texture, (UV* 5.6) + (displacement_x - displacement_y) - (TIME* 0.05));

	ALBEDO = tex_color.rgb;
	ALPHA = 0.3 ;
}