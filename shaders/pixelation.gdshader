shader_type canvas_item;

uniform float pixel_size : hint_range(0.00,1, 0.01) = 0.5;

void fragment() {
	//Self-pixelation
	vec2 pixelNumber = vec2(textureSize(TEXTURE, 0)) * pixel_size;
    vec2 pixelatedUV = round(UV * pixelNumber) /pixelNumber;
	COLOR = texture(TEXTURE, pixelatedUV);
}