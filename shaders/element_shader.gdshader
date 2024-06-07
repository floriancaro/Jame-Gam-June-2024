shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform bool fire = false; // you can assign a default value to uniforms
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
	COLOR.r = 0.0;
	COLOR.b = 0.0;
  }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
