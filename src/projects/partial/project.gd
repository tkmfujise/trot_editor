extends MarginContainer

signal selected(record: DB_Record)
var record : DB_Record # DB.Project


func initialize(_record: DB_Record) -> void:
	record = _record
	update()


func update() -> void:
	if not record: return
	%Name.text = record.name
	%HoofprintsCount.text = str(record.hoofprints_count())
	%UpdatedAt.text = record.updated_at


func _on_button_pressed() -> void:
	selected.emit(record)
