shader_type canvas_item;

uniform sampler2D friend_viewport;

void fragment() {
	COLOR = texture(friend_viewport,UV);
}

