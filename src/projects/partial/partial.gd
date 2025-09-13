extends CenterContainer

var model : DB_Record # DB.Project


func initialize(_model: DB_Record) -> void:
	model = _model
	update()


func update() -> void:
	if not model: return
	%Label.text = model.name
