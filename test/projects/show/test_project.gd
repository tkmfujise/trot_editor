extends GutTestMeta

var Scene = preload("res://src/projects/show/project.tscn")
var scene = null
var project = null


func before_each():
	setup_db()
	scene = Scene.instantiate()
	add_child(scene)


func after_each():
	DB.Hoofprint.delete_all()
	DB.Project.delete_all()


func test_initialize():
	project = DB.Project.create({ "name": "test" })
	scene.initialize(project)
	assert_not_null(scene.record)


func test_back_button_pressed():
	project = DB.Project.create({ "name": "test" })
	assert_eq(DB.Hoofprint.count(), 0)
	scene.initialize(project)
	assert_eq(DB.Hoofprint.count(), 1)
	scene._on_back_button_pressed()
	assert_eq(DB.Hoofprint.count(), 1)
	assert_ne(scene, get_tree().current_scene)
	get_tree().quit()


func test_on_collapse_button_pressed():
	var window_height = get_window().size.y
	scene._on_collapse_button_pressed()
	assert_eq(scene.find_child('TabContainer').visible, false)
	assert_eq(scene.find_child('CollapseButton').text, '+')
	assert_ne(get_window().size.y, window_height)
	scene._on_collapse_button_pressed()
	assert_eq(scene.find_child('TabContainer').visible, true)
	assert_eq(scene.find_child('CollapseButton').text, '-')
	assert_eq(get_window().size.y, window_height)
