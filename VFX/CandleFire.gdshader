shader_type spatial;
render_mode unshaded;
//render_mode blend_add;
//render_mode cull_disabled

uniform sampler2D flame_texture : repeat_disable;

uniform sampler2D noise;
uniform sampler2D noise2;


uniform sampler2D color_gradient;

varying float y_pos;
void vertex() {
	y_pos = (VERTEX.y+1.0)*0.5;


	UV=UV;
	mat4 mat_world = mat4(normalize(INV_VIEW_MATRIX[0]), normalize(INV_VIEW_MATRIX[1]) ,normalize(INV_VIEW_MATRIX[2]), MODEL_MATRIX[3]);
	mat_world = mat_world * mat4(vec4(cos(INSTANCE_CUSTOM.x), -sin(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(sin(INSTANCE_CUSTOM.x), cos(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
	MODELVIEW_MATRIX = VIEW_MATRIX * mat_world;
	MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);

}

void fragment() {


	float noise_value = texture(noise,vec2(UV.x-TIME*0.1,UV.y+TIME)).r * texture(noise2,vec2(UV.x+TIME*0.1,UV.y+TIME*0.5)).r;
	
	
	float flame_mask = texture(flame_texture,vec2(UV.x-0.05+noise_value*clamp(pow(y_pos,2.0),0.0,1.0),UV.y)).a;

	float color_mask = (flame_mask*noise_value);

	vec3 fire_color = texture(color_gradient,vec2(color_mask,0.0)).rgb;

	ALBEDO = fire_color;
	//ALBEDO = vec3(color_mask+noise_value);
	ALPHA = color_mask * ALPHA_SCISSOR_THRESHOLD*50.0;

}

