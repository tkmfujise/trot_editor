extends Control

@export var Partial : PackedScene


func _ready() -> void:
	for project in DB.Project.all():
		var partial = Partial.instantiate()
		partial.initialize(project)
		partial.selected.connect(_project_selected)
		%Container.add_child(partial)


func _project_selected(project: DB_Record) -> void:
	%ProjectTransition.transit([project])
