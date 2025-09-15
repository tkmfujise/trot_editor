extends GutTestMeta

var Scene = preload("res://src/hoofprints/show/hoofprint.tscn")
var scene = null

func before_each():
	setup_db()
	scene = Scene.instantiate()
	add_child(scene)


func test_ready():
	assert_not_null(scene)


func test_initialize():
	var project = DB.Project.create({ 'name': 'Foo' })
	var hoofprint = project.find_or_build_hoofprint(TimeHelper.today())
	scene.initialize(hoofprint)
	assert_not_null(scene.record)


func test_running_unless_record():
	scene.running = true
	assert_null(scene.record)
	scene.running = false
	assert_eq(DB.Hoofprint.count(), 0)


func test_running_if_record():
	var project = DB.Project.create({ 'name': 'Foo' })
	var hoofprint = project.find_or_build_hoofprint(TimeHelper.today())
	scene.initialize(hoofprint)
	assert_eq(DB.Hoofprint.count(), 0)
	scene.running = true
	assert_eq(DB.Hoofprint.count(), 1)
	scene.running = false
	assert_eq(DB.Hoofprint.count(), 1)


func test_formmatted_passed_time_0():
	var str = scene.formatted_passed_time()
	assert_eq(scene.passed_time, 0)
	assert_typeof(str, TYPE_STRING)
	assert_eq(str, '00:00:00')


func test_formmatted_passed_time_61():
	scene.passed_time = 61.123456789
	var str = scene.formatted_passed_time()
	assert_typeof(str, TYPE_STRING)
	assert_eq(str, '00:01:01')


func test_formmatted_passed_time_3601():
	scene.passed_time = 3601.123456789
	var str = scene.formatted_passed_time()
	assert_typeof(str, TYPE_STRING)
	assert_eq(str, '01:00:01')


func test_formmatted_passed_time_3661():
	scene.passed_time = 3661.123456789
	var str = scene.formatted_passed_time()
	assert_typeof(str, TYPE_STRING)
	assert_eq(str, '01:01:01')


func test_formmatted_passed_time_max():
	scene.passed_time = 1.79769e+308
	var str = scene.formatted_passed_time()
	assert_typeof(str, TYPE_STRING)
	assert_eq(str, '2562047788015215:30:07')


func test_fit_horse_position():
	scene.fit_horse_position()
	assert_ne(scene.find_child('Icon').position.x, 0)
	scene.passed_time = 1
	scene.fit_horse_position()
	assert_ne(scene.find_child('Icon').position.x, 0)
	scene.passed_time = 30*60 + 1
	scene.fit_horse_position()
	assert_ne(scene.find_child('Icon').position.x, 0)
