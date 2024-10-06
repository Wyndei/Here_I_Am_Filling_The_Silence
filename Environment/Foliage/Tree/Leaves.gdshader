shader_type spatial;

//render_mode unshaded;
render_mode diffuse_toon, specular_toon;
render_mode cull_disabled, depth_draw_opaque;
render_mode ensure_correct_normals;

uniform float rimlight_threshold : hint_range(0.0, 5.0, 0.1) = 0.0;
uniform float rimlight_intensity : hint_range(0.0, 5.0, 0.1) = 1.0;
uniform float height_threshold : hint_range(-3.0, 3.0, 0.1) = 0.0;

uniform vec3 tint : source_color;
uniform vec3 tint2 : source_color;
uniform sampler2D BranchTex;
uniform sampler2D colourNoise;

uniform float Wind_Scale : hint_range(-2.0, 2.0, 0.1) = 0.5;
uniform float Wind_Speed : hint_range(-2.0, 2.0, 0.1) = 0.5;
uniform sampler2D Wind_Noise;

uniform sampler2D rampTex;


varying vec3 world_pos;
varying vec3 colour_pos;
varying vec3 pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX*350.0, 1.0)).xyz;
	colour_pos = (MODEL_MATRIX * vec4(VERTEX*0.001, 1.0)).xyz;
	pos = VERTEX;
	
	
	VERTEX.y += texture(Wind_Noise,world_pos.xz+TIME * Wind_Speed * 0.01).r*0.5;
	
	//playerpos
	//VERTEX.xz += (clamp(NODE_POSITION_WORLD-Player_Position,-1.0,1.0).xz 
	//* abs(clamp(-distance(Player_Position,NODE_POSITION_WORLD) + 1.25,0.0,1.0)) * (pos.y+1.0)) * 0.5;
	//VERTEX.y -= (abs(clamp(-distance(Player_Position,NODE_POSITION_WORLD) + 1.25,0.0,1.0)) * ((pos.y+0.5)*0.5));
	
}

void fragment() {
	float dotp = dot(NORMAL,VIEW);
	
	float side = FRONT_FACING ? 1.0 : -1.0; // forces normal to face rendered side
	NORMAL = side * NORMAL;
	
	float colourValue = texture(colourNoise,colour_pos.xz*0.005).r;
	vec3 colourMix = mix(tint2,tint,clamp((pos.y+1.0 + height_threshold)*0.1,0.0,1.0));
	
	ALBEDO = colourMix;
	ALPHA = texture(BranchTex,UV).a * ALPHA_SCISSOR_THRESHOLD*50.0;
	float dist = distance(VERTEX,VIEW);
	ALPHA *= clamp(mix(0.0,1.0,dist*0.01),0.0,1.0);
	
}


void light() {
	float dist = distance(VIEW,pos)*0.25;
	
	float fresnel_value = texture(BranchTex,UV).a * 0.4;
	float fresnel = dot(-VIEW+rimlight_threshold,NORMAL) - fresnel_value * 2.0;
	
	
	float dotp = dot(NORMAL,LIGHT) * (ATTENUATION);
	dotp = clamp(dotp,0.02,0.98);
	vec3 ramp = texture(rampTex,vec2(dotp,0)).xyz;
	DIFFUSE_LIGHT += ((LIGHT_COLOR + clamp((fresnel)*10.0 * rimlight_intensity,0.0,10.0 * rimlight_intensity)) * ramp) ;
	
}


