extends TextureProgressBar

@onready var rotor = $"../Rotor"

func update(amount):
	match amount:
		0:
			value = 0
			rotor.pitch_scale = 1.
		1:
			value = 35
			modulate = "#91db69"
			rotor.pitch_scale = 0.9
		2:
			value = 65
			modulate = "#f9c22b"
			rotor.pitch_scale = 0.7
		3:
			value = 100
			modulate = "#e83b3b"
			rotor.pitch_scale = 0.5
