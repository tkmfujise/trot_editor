extends Sprite2D


func idle() -> void: animate("idle")
func trot() -> void: animate("trot")
func canter() -> void: animate("canter")


func animate(style: String) -> void:
	%AnimationPlayer.play(style)
	match style:
		'trot': %TrotTimer.start()
		_: %TrotTimer.stop()


func _on_trot_timer_timeout() -> void:
	canter()
