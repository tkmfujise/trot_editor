extends Control


func _ready() -> void:
	DB.recreate_tables()
	var project = DB.Project.create({ "name": "bar" })
	var runner  = DB.Runner.create({ "path": "./icon.svg", "project_id": project.id })
	runner.start()
