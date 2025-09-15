extends Control

const OFFSET = 30

@export var running : bool = false : set = set_running
@export var goal_min : int = 30 : set = set_goal_min

var record : DB_Record # DB.Hoofprintt
var passed_time : float : set = set_passed_time
var goal_time : int
var goal_distance : float = 1.0


func initialize(_record: DB_Record) -> void:
	record = _record


func set_running(val: bool) -> void:
	running = val
	if running: %Horse.trot()
	else: %Horse.idle()
	if record: record.save()


func set_goal_min(minutes: int) -> void:
	goal_min  = minutes
	goal_time = goal_min * 60
	%GoalLabel.text = str(minutes)


func set_passed_time(seconds: float) -> void:
	passed_time = seconds
	%PassedTime.text = formatted_passed_time()
	if record: record.duration = floor(passed_time)


func _process(delta: float) -> void:
	if not running: return
	passed_time += delta
	if goal_time > passed_time:
		%Icon.position.x = passed_time * goal_distance / goal_time


func formatted_passed_time() -> String:
	var time = int(passed_time)
	var hour    = time / 60 / 60
	var minutes = (time / 60) % 60
	var sconds  = time % 60
	return '%02d:%02d:%02d' % [hour, minutes, sconds]


func _on_resized() -> void:
	goal_distance = get_viewport_rect().end.x - OFFSET
