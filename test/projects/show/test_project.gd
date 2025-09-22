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


func test_shortcut_input():
	project = DB.Project.create({ "name": "test" })
	scene.initialize(project)
	var event = InputEventKey.new()
	event.pressed = true
	# - Testing: TabContainer
	event.ctrl_pressed = true
	event.keycode = KEY_BRACKETRIGHT
	scene._shortcut_input(event)
	assert_eq(scene.find_child('TabContainer').current_tab, 1)
	event.keycode = KEY_BRACKETLEFT
	scene._shortcut_input(event)
	assert_eq(scene.find_child('TabContainer').current_tab, 0)
	# - Testing: CollapseButton
	event.keycode = KEY_MINUS
	scene._shortcut_input(event)
	assert_eq(scene.find_child('TabContainer').visible, false)
	scene._shortcut_input(event)
	assert_eq(scene.find_child('TabContainer').visible, true)


func test_back_button_pressed():
	project = DB.Project.create({ "name": "test" })
	assert_eq(DB.Hoofprint.count(), 0)
	scene.initialize(project)
	assert_eq(DB.Hoofprint.count(), 1)
	scene._on_back_button_pressed()
	assert_eq(DB.Hoofprint.count(), 1)
	await get_tree().process_frame
	assert_eq(get_tree().current_scene.name, 'Projects')
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
