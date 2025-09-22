extends MarginContainer

var record : DB_Record # DB.Project


func initialize(project: DB_Record) -> void:
	record = project
	%DeleteButton.visible = !!(record.id)
	set_values()


func set_values() -> void:
	for field in %Form.get_children():
		var column = field.name.replace('Field', '').to_snake_case()
		field.find_child('Input').text = record.get(column)


func read_values() -> void:
	for field in %Form.get_children():
		var column = field.name.replace('Field', '').to_snake_case()
		record.set(column, field.find_child('Input').text)


func _on_back_button_pressed() -> void:
	if record and record.id:
		%ProjectTransition.transit([record])
	else:
		%ProjectsTransition.transit()


func _on_submit_button_pressed() -> void:
	if not record: return
	read_values()
	record.save()
	if not record.errors:
		%ProjectTransition.transit([record])


func _on_delete_button_pressed() -> void:
	%DeleteConfirmationDialog.show()


func _on_delete_confirmation_dialog_confirmed() -> void:
	if not record: return
	record.destroy()
	%ProjectsTransition.transit()
