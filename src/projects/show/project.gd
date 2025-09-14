extends Control

var record : DB_Record


func initialize(_record: DB_Record) -> void:
	record = _record
	var hoofprint = record.find_or_build_hoofprint(TimeHelper.today())
	%Hoofprint.initialize(hoofprint)


func _on_start_button_pressed() -> void:
	%Hoofprint.running = !%Hoofprint.running
	if %Hoofprint.running:
		%StartButton.text = 'Stop'
	else:
		%StartButton.text = 'Start'


func _on_back_button_pressed() -> void:
	%Hoofprint.running = false
	record.save()
	%BackTransition.transit()
