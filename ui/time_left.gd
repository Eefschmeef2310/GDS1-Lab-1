extends TextureProgressBar

@export var gradient : Gradient

@onready var game_over_timer = $GameOverTimer

func update():
	var percentage = (game_over_timer.time_left / game_over_timer.wait_time)
	
	value = percentage * 100
	(texture_progress as GradientTexture1D).gradient.offsets[1] = percentage
	
	#Color
	tint_progress = gradient.sample(percentage)
