shader_type spatial;



uniform vec3 dark_tint : source_color;
uniform sampler2D sand_ramp;

uniform sampler2D normal_noise;
uniform sampler2D normal_noise2;

uniform sampler2D wind_noise;
uniform sampler2D wind_noise2;

uniform sampler2D specular_noise;

uniform sampler2D sand_noise;
uniform sampler2D sand_noise2;

uniform float sand_height : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform sampler2D deformMask;


varying vec3 world_pos;
void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;

	float deform_value = texture(deformMask,UV).r;

	VERTEX.y += sand_height - deform_value * sand_height;

}

void fragment() {
	
	float deform_value = texture(deformMask,UV).r;
	
	float wind_value = texture(wind_noise,world_pos.xz*0.05+TIME*0.075).r *
					   texture(wind_noise2,world_pos.xz*0.05+TIME*0.25).r*0.25 * abs(deform_value-1.0);

	float specular_value = texture(specular_noise,world_pos.xz).r;

	float sand_value = texture(sand_noise,world_pos.xz*0.1+TIME*0.01).r * texture(sand_noise2,world_pos.xz*0.25).r;
	vec3 sand_color = texture(sand_ramp,vec2(sand_value)).rgb;

	vec3 normal_value = texture(normal_noise,world_pos.xz*0.1+TIME*0.01).rgb *
				 	   texture(normal_noise2,world_pos.xz*0.1+TIME*0.05).rgb*0.25 * abs(deform_value-1.0);
	
	vec3 sand = mix(sand_color,dark_tint,deform_value);
	
	SPECULAR = specular_value*0.5;
	ALBEDO = sand + wind_value * sand_color;
	//NORMAL_MAP = normal_value*0.0;
	
	//ALBEDO = vec3(texture(deformMask,UV).rgb);
}


