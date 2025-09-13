extends Control

const OFFSET = 30
var passed_time : float
var goal_time : int
var goal_distance : float = 1.0


func _ready() -> void:
	goal_time = 1*60


func _process(delta: float) -> void:
	if goal_time < passed_time: set_process(false)
	passed_time += delta
	%Icon.position.x = passed_time * goal_distance / goal_time


func _on_resized() -> void:
	goal_distance = get_viewport_rect().end.x - OFFSET
