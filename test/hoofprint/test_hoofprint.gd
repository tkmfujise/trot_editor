extends GutTestMeta

var Scene = preload("res://src/hoofprint/hoofprint.tscn")
var scene = null

func before_each():
	scene = Scene.instantiate()
	add_child(scene)


func test_ready():
	assert_not_null(scene)
