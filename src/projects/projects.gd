extends Control

@onready var Card := preload("res://src/projects/card/card.tscn")


func _ready() -> void:
	for project in DB.Project.all():
		var card = Card.instantiate()
		card.initialize(project)
		%Container.add_child(card)
