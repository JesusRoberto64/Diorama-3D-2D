shader_type spatial;
render_mode cull_disabled;

uniform sampler2D Text : source_color;

// Parámetros ajustables
uniform float wind_speed = 1.0;
uniform float wind_strength = 0.2;
uniform float wind_frequency = 2.0;
uniform vec2 wind_direction = vec2(1.0, 0.5); // Dirección del viento (x,z)

void vertex() {
	// Invertimos UV.y: 1 = superior, 0 = inferior
    float is_top = 1.0 - UV.y; // ¡Cambio clave aquí!

    float wave = cos(TIME * wind_speed + VERTEX.x * wind_frequency) * wind_strength;

    VERTEX.x += wave * wind_direction.x * is_top;
    VERTEX.z += wave * wind_direction.y * is_top;
    VERTEX.y += abs(wave) * 0.1 * is_top;
}

void fragment() {
	vec4 _text = texture(Text, UV);
	ALBEDO = _text.rgb;
	ALPHA = _text.a;
}

