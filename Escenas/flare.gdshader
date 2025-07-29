shader_type spatial;
render_mode cull_disabled, blend_add;

uniform float ray_1_freq = 28.0;
uniform float ray_1_speed = -0.7;
uniform float ray_1_strength = 0.3;

float rayValue (in vec2 coord, in float frequency, in float travelRate, in float maxStrength)
{
	// Fade de bordes
	vec2 centered = 2.0 * (coord - 0.5);
	vec2 fade = min(vec2(1.0), 3.5 - 3.5 * centered * centered);

	// Componente horizontal animada
	float xMod = 0.5 * (cos(TIME * travelRate + coord.x * frequency) + 1.0);

	// Componente vertical estática
	float yMod = sin(coord.y * 3.1416); // PI para mejorar distribución

	return maxStrength * xMod * yMod * fade.x * fade.y;
}

void fragment() {
	vec2 uv = UV;

	// Crear rayos
	float ray1 = rayValue(uv, ray_1_freq, ray_1_speed, ray_1_strength);
	float ray2 = rayValue(uv, 30.0, 0.1, 0.4);
	float ray3 = rayValue(uv, 10.0, -0.05, 0.4);
	float ray4 = rayValue(uv, 72.0, 0.9, 0.1);

	float total = ray1 + ray2 + ray3 + ray4;

	ALBEDO = vec3(total) + vec3(0.1, 0.7, 0.05);
	float fresnel = dot(NORMAL, VIEW);
	ALPHA = pow(fresnel, 6.0) * total * 0.1;
	//ALPHA = total * 0.25 ;
}

