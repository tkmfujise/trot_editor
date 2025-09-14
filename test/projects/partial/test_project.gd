extends GutTestMeta

var Scene = preload("res://src/projects/partial/project.tscn")
var scene = null
var project = null


func before_each():
	setup_db()
	scene = Scene.instantiate()
	add_child(scene)


func test_initialize():
	project = DB.Project.create({ "name": "test" })
	scene.initialize(project)
	assert_not_null(scene.record)
