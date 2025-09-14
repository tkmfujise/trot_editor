extends Node

@export_file('*.tscn') var next_scene_path : String
@export var preload_scene : bool =  false


func _ready() -> void:
	if preload_scene: load_next_scene()


func transit(args: Array = []) -> void:
	if not preload_scene: load_next_scene()
	var current = get_tree().current_scene
	var status := loading_status()
	while status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await current.get_tree().process_frame
		status = loading_status()

	var pack = ResourceLoader.load_threaded_get(next_scene_path)
	var next_scene = pack.instantiate()
	if args: next_scene.initialize.callv(args)
	current.get_tree().root.add_child(next_scene)
	current.get_tree().current_scene = next_scene
	current.queue_free()


func load_next_scene() -> void:
	ResourceLoader.load_threaded_request(next_scene_path)


func loading_status() -> int:
	return ResourceLoader.load_threaded_get_status(next_scene_path)
