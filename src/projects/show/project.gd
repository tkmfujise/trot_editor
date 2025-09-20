extends Control

var record : DB_Record
var tab_content_height : int


func initialize(_record: DB_Record) -> void:
	record = _record
	%ProjectName.text = record.name
	var hoofprint = record.find_or_build_hoofprint(TimeHelper.today())
	%Hoofprint.initialize(hoofprint)
	%Hoofprint._on_start_button_pressed()


func _on_back_button_pressed() -> void:
	%Hoofprint.running = false
	if record: record.save()
	%BackTransition.transit()


func _on_collapse_button_pressed() -> void:
	%TabContainer.visible = !%TabContainer.visible
	%CollapseButton.text  = '-' if %TabContainer.visible else '+'
	WindowHelper.resize_y_with(%TabContainer)
