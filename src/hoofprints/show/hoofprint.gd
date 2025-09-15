extends Control

const OFFSET := 60

@export var running : bool = false : set = set_running
@export var goal_min : int = 30 : set = set_goal_min

var record : DB_Record # DB.Hoofprintt
var passed_time : float : set = set_passed_time
var goal_time : int = 1
var goal_distance : float = 1.0


func initialize(_record: DB_Record) -> void:
	record = _record


func _ready() -> void:
	fit_goal_distance()


func set_running(val: bool) -> void:
	running = val
	if is_node_ready():
		if running: %Horse.trot()
		else:       %Horse.idle()
	if record: record.save()


func set_goal_min(minutes: int) -> void:
	goal_min  = minutes
	goal_time = goal_min * 60.0
	if not is_node_ready(): await ready
	%GoalLabel.text = str(minutes)


func set_passed_time(seconds: float) -> void:
	passed_time = seconds
	%PassedTime.text = formatted_passed_time()
	if record: record.duration = floor(passed_time)


func _process(delta: float) -> void:
	if not running: return
	passed_time += delta
	if goal_time > passed_time: fit_horse_position()


func formatted_passed_time() -> String:
	var time = int(passed_time)
	var hour    = time / 60 / 60
	var minutes = (time / 60) % 60
	var sconds  = time % 60
	return '%02d:%02d:%02d' % [hour, minutes, sconds]


func fit_goal_distance() -> void:
	goal_distance = %HorseContainer.get_viewport_rect().end.x - OFFSET


func fit_horse_position() -> void:
	var traveled = [passed_time, goal_time].min()
	%Icon.position.x = traveled * goal_distance / goal_time


func _on_resized() -> void:
	if is_node_ready():
		fit_goal_distance()
		fit_horse_position()
