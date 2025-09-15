extends GutTestMeta

const Scene = preload("res://src/hoofprints/horse/horse.tscn")
var scene = null


func before_each():
	scene = Scene.instantiate()
	add_child(scene)


func test_ready():
	assert_not_null(scene)


func test_idle():
	scene.idle()
	assert_eq(scene.find_child('AnimationPlayer').current_animation, 'idle')


func test_trot():
	scene.trot()
	assert_eq(scene.find_child('AnimationPlayer').current_animation, 'trot')


func test_canter():
	scene.canter()
	assert_eq(scene.find_child('AnimationPlayer').current_animation, 'canter')
