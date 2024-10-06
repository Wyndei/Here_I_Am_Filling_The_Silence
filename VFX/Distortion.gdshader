shader_type spatial;
render_mode unshaded,depth_test_disabled,fog_disabled;

uniform sampler2D noise;
uniform sampler2D noise2;

uniform sampler2D depth_texture : hint_depth_texture;
uniform sampler2D screen_texture : hint_screen_texture,repeat_disable;

uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1.0;

void vertex() {
	POSITION = vec4(VERTEX,1.0);
}

void fragment() {

	float depth = abs(texture(depth_texture,SCREEN_UV).r);
	depth = 1.0 - 2.0 * depth;
	depth = pow(depth,50.0)*0.25;

	float noise_value = texture(noise,SCREEN_UV+TIME*0.2).r * texture(noise2,SCREEN_UV+TIME*0.1).r*0.1;

	vec3 screen = texture(screen_texture,SCREEN_UV+(noise_value-0.05)*depth).rgb;


	ALBEDO = screen;
	ALPHA = alpha;
	//ALBEDO = vec3(depth);
}