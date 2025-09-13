extends CenterContainer

signal selected(model: DB_Record)
var model : DB_Record # DB.Project


func initialize(_model: DB_Record) -> void:
	model = _model
	update()


func update() -> void:
	if not model: return
	%Name.text = model.name
	%CreatedAt.text = model.created_at
	%UpdatedAt.text = model.updated_at


func _on_name_pressed() -> void:
	selected.emit(model)
