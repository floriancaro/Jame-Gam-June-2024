shader_type canvas_item;

uniform float white_progress : hint_range(0,1) = 0;

vec3 interpolate_vec3(vec3 start, vec3 end, float delta){
	return start + (end - start) * delta;
}

uniform bool damaged = false;
uniform bool fire = false;
uniform bool ice = false;
uniform bool teleport = false;

void fragment(){
  COLOR = texture(TEXTURE, UV); // Read from texture
  if (fire == true) {
	COLOR.r = 1.0;
	COLOR.b = 0.0;
  } else if (ice == true) {
	COLOR.r = 0.0;
	COLOR.b = 1.0;
  } else if (teleport == true) {
	COLOR.r = 1.0;
	COLOR.b = 1.0;
  } else {
    COLOR = texture(TEXTURE, UV); // Read from texture
  }

  if(damaged == true) {
	vec4 origin = texture(TEXTURE, UV);
	COLOR.rgb = interpolate_vec3(origin.rgb, vec3(1,1,1), white_progress);
	COLOR.a = origin.a;
  }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
