shader_type canvas_item;


uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {

	float dist = distance(SCREEN_UV,vec2(0.5,0.5));

	vec3 screen = vec3(texture(screen_texture,SCREEN_UV+0.005*dist).r,
					   texture(screen_texture,SCREEN_UV).g,
					   texture(screen_texture,SCREEN_UV-0.005*dist).b);


	COLOR = vec4(screen,1.0);
}
