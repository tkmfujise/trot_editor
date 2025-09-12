extends Node

var path := "res://data/trot-dev.db"
#const verbosity_level : int = SQLite.VERBOSE
const verbosity_level : int = SQLite.NORMAL
var conn : SQLite

# Model
const _Project   = preload("res://src/db/models/project.gd")
const _Runner    = preload("res://src/db/models/runner.gd")
const _Hoofprint = preload("res://src/db/models/hoofprint.gd")
@onready var Project   = _Project.new()
@onready var Runner    = _Runner.new()
@onready var Hoofprint = _Hoofprint.new()


func _ready() -> void:
	open()


func open(_path: String = path) -> void:
	conn = SQLite.new()
	conn.path = _path
	conn.verbosity_level = verbosity_level
	conn.foreign_keys = true
	conn.open_db()


func reopen(new_path: String) -> void:
	close()
	open(new_path)


func close() -> void:
	conn.close_db()


func recreate_tables() -> void:
	DB.Project.recreate_table()
	DB.Runner.recreate_table()
	DB.Hoofprint.recreate_table()
