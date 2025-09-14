extends CenterContainer

signal selected(record: DB_Record)
var record : DB_Record # DB.Project


func initialize(_record: DB_Record) -> void:
	record = _record
	update()


func update() -> void:
	if not record: return
	%Name.text = record.name
	%CreatedAt.text = record.created_at
	%UpdatedAt.text = record.updated_at


func _on_name_pressed() -> void:
	selected.emit(record)
