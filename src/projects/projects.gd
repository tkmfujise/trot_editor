extends Control

@export var Partial : PackedScene


func _ready() -> void:
	for project in DB.Project.all():
		var partial = Partial.instantiate()
		partial.initialize(project)
		%Container.add_child(partial)
