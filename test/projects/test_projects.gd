extends GutTestMeta

var Scene = preload("res://src/projects/projects.tscn")
var scene = null


func before_each():
	setup_db()


func setup_scene():
	scene = Scene.instantiate()
	add_child(scene)


func test_ready_unless_projects():
	setup_scene()
	var container = scene.find_child('Container')
	assert_not_null(container)
	assert_eq(container.get_child_count(), 0)


func test_ready_if_projects():
	DB.Project.create({ "name": "Foo" })
	DB.Project.create({ "name": "Bar" })
	setup_scene()
	var container = scene.find_child('Container')
	assert_not_null(container)
	assert_ne(container.get_child_count(), 0)
