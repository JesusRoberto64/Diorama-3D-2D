shader_type spatial;

render_mode unshaded, depth_draw_opaque, depth_test_disabled;
uniform sampler2D DEPTH_TEXTURE: hint_depth_texture, filter_linear_mipmap;
uniform sampler2D albedo_texture : source_color;
uniform vec4 siluet_color: source_color;

void vertex() {
	vec3 base_y = vec3(MODEL_MATRIX[0][1], MODEL_MATRIX[1][1], MODEL_MATRIX[2][1]);
	 vec3 scale = vec3(
        length(vec3(MODEL_MATRIX[0].xyz)),
        length(vec3(MODEL_MATRIX[1].xyz)),
        length(vec3(MODEL_MATRIX[2].xyz))
    );

	mat4 modified_model_view = VIEW_MATRIX * mat4(
        INV_VIEW_MATRIX[0]* scale.y,
        INV_VIEW_MATRIX[1]* scale.y,
        INV_VIEW_MATRIX[2]* scale.y,
        MODEL_MATRIX[3]
    ) ;
    MODELVIEW_MATRIX = modified_model_view;
}

void fragment() {
	vec4 tex_color = texture(albedo_texture, UV);
    if (FRAGCOORD.z > texture(DEPTH_TEXTURE, SCREEN_UV).r) {
        ALBEDO = siluet_color.rgb;
        ALPHA = tex_color.a * siluet_color.a;
    } else {
		ALPHA = 0.0;
		}
}


