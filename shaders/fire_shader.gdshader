shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float red = 1.0; // you can assign a default value to uniforms

void fragment(){
  COLOR = texture(TEXTURE, UV); // Read from texture
  COLOR.r = red;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
