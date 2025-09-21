extends GutTestMeta

const Scene = preload("res://src/main.tscn")
var scene = null


func before_each():
	scene = Scene.instantiate()
	add_child(scene)


func test_resize_with():
	WindowHelper.resize_with(scene)
	assert_gt(get_window().size.x, 0)
	assert_gt(get_window().size.y, 0)


func test_resize_x_with():
	WindowHelper.resize_x_with(scene)
	assert_gt(get_window().size.x, 0)
	assert_gt(get_window().size.y, 0)


func test_resize_y_with():
	WindowHelper.resize_y_with(scene)
	assert_gt(get_window().size.x, 0)
	assert_gt(get_window().size.y, 0)
