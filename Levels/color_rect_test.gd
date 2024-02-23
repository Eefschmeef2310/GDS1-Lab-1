extends TextureRect

func _ready():
	(texture as NoiseTexture2D).color_ramp.colors[1] = Color(randf(), randf(), randf(), 1.)
	
	#color = Color(randf(), randf(), randf(), 1.)
