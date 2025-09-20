extends Control

var record : DB_Record


func initialize(_record: DB_Record) -> void:
	record = _record
	%ProjectName.text = record.name
	var hoofprint = record.find_or_build_hoofprint(TimeHelper.today())
	%Hoofprint.initialize(hoofprint)


func _on_back_button_pressed() -> void:
	%Hoofprint.running = false
	if record: record.save()
	%BackTransition.transit()
