extends ColorRect

const NONE := Color8(239, 242, 245)
const BASE := Color8(219, 155, 105)
const BAND := 0.5


func _ready() -> void:
	color = BASE
	color = color.darkened(randf() * BAND)
	if randf() > 0.5:
		color = NONE
