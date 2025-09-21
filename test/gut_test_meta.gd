extends GutTest
class_name GutTestMeta

var _always_on_top : bool


func before_all():
	var window = get_tree().current_scene.get_window()
	_always_on_top = window.always_on_top
	window.always_on_top = false


func after_all():
	get_tree().current_scene.get_window().always_on_top = _always_on_top


func transition_with(f: Callable):
	var prev_scene = get_tree().current_scene
	f.call()
	while prev_scene == get_tree().current_scene:
		await get_tree().process_frame


func setup_db():
	DB.reopen("res://data/trot-test.db")
	DB.recreate_tables()


func assert_match(val, str):
	var regex = RegEx.new()
	regex.compile(str)
	assert_not_null(regex.search(val))


func assert_match_time_str(val):
	assert_match(val, '^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}$')
