extends MarginContainer

var record : DB_Record # DB.Project


func initialize(project: DB_Record) -> void:
	record = project


func _on_back_button_pressed() -> void:
	if record and record.id:
		%ProjectTransition.transit([record])
	else:
		%ProjectsTransition.transit()
