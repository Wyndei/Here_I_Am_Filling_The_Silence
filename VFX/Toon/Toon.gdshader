shader_type spatial;
//render_mode unshaded;


uniform vec3 color : source_color;
uniform sampler2D surface_texture;

uniform sampler2D light_ramp;

uniform bool rim_light = false;
uniform float rim_light_intensity : hint_range(0.0, 1.0, 0.01) = 0.5;

void fragment() {


	ALBEDO = texture(surface_texture,UV).rgb * color;
}

void light() {

	float NdotL = dot(NORMAL,LIGHT) * (ATTENUATION) * 1.0;

	float NdotV = dot(-NORMAL,VIEW);

	float fresnel_value;

	if (rim_light){
	fresnel_value = clamp((-round(NdotV+rim_light_intensity*2.0))+1.0,0.0,1.0);
	}

	NdotL = clamp(NdotL,0.02,0.98);
	vec3 ramp = texture(light_ramp,vec2(NdotL,0)).xyz;
	DIFFUSE_LIGHT += ((LIGHT_COLOR) * ramp) - (fresnel_value * ramp * 2.0);


}
