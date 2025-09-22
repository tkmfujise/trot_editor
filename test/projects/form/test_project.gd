extends GutTestMeta

const Scene = preload("res://src/projects/form/project.tscn")
var scene = null


func before_each():
	scene = Scene.instantiate()
	add_child(scene)


func test_initialize_if_new():
	var project = DB.Project.new_record({ 'name': 'Test' })
	scene.initialize(project)
	assert_eq(scene.record, project)
	assert_eq(scene.find_child('DeleteButton').visible, false)


func test_initialize_if_existing():
	var project = DB.Project.create({ 'name': 'Test' })
	scene.initialize(project)
	assert_eq(scene.record, project)
	assert_eq(scene.find_child('NameField').find_child('Input').text, 'Test')
	assert_eq(scene.find_child('DeleteButton').visible, true)


func test_on_back_button_pressed_if_new():
	var project = DB.Project.new_record({ 'name': 'Test' })
	scene.initialize(project)
	await transition_with(scene._on_back_button_pressed)
	assert_eq(get_tree().current_scene.name, 'Projects')
	get_tree().quit()


func test_on_back_button_pressed_if_existing():
	var project = DB.Project.create({ 'name': 'Test' })
	scene.initialize(project)
	await transition_with(scene._on_back_button_pressed)
	assert_eq(get_tree().current_scene.name, 'Project')
	get_tree().quit()


func test_on_submit_button_pressed():
	var project = DB.Project.new_record()
	scene.initialize(project)
	scene.find_child('NameField').find_child('Input').set_text('Bar')
	scene._on_submit_button_pressed()
	await get_tree().process_frame
	# await transition_with(scene._on_back_button_pressed)
	assert_eq(DB.Project.last().name, 'Bar')
	assert_eq(get_tree().current_scene.name, 'Project')
	get_tree().quit()


func test_on_delete_button_pressed():
	var project = DB.Project.create({ 'name': 'Foo' })
	var dialog  = scene.find_child('DeleteConfirmationDialog')
	scene.initialize(project)
	assert_eq(dialog.visible, false)
	scene._on_delete_button_pressed()
	assert_eq(dialog.visible, true)
	dialog.confirmed.emit()
	await get_tree().process_frame
	assert_eq(project.reload(), false)
	assert_eq(get_tree().current_scene.name, 'Projects')
	get_tree().quit()
