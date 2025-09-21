extends Control

enum Tab { Hoofprints, Memo, Files, REPL, Settings }

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
	if not %TabContainer.visible:
		%TabContainer.visible = true
		WindowHelper.resize_y_with(%TabContainer)
	%BackTransition.transit()


func _on_edit_button_pressed() -> void:
	%Hoofprint.running = false
	if record:
		record.save()
		%EditTransition.transit([record])


func _on_collapse_button_pressed() -> void:
	%TabContainer.visible = !%TabContainer.visible
	%CollapseButton.text  = '-' if %TabContainer.visible else '+'
	WindowHelper.resize_y_with(%TabContainer)


func _on_tab_container_tab_changed(tab: int) -> void:
	match tab:
		Tab.Memo: %Editor.grab_focus()
		_: pass
