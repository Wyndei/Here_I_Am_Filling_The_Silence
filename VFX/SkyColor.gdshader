shader_type sky;

uniform vec3 color : source_color;

uniform vec3 star_color : source_color;

uniform sampler2D star_noise;
uniform sampler2D star_noise2;

uniform float star_amount : hint_range(0.0, 1.0, 0.1) = 1.0;

void sky() {
	
	vec2 star_mask = EYEDIR.xz+TIME*0.01;
	
	float star_value = texture(star_noise,star_mask).r * texture(star_noise,star_mask).r*pow(EYEDIR.y,4.0)*0.01; 
	star_value = clamp(star_value,0.0,1.0) * 100.0;
	
	COLOR = vec3(color) + star_color * star_value * star_amount;
	//COLOR = vec3(EYEDIR.y);
}
