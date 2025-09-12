extends GutTestMeta

var project

func before_each():
	DB.reopen("res://data/trot-test.db")
	DB.recreate_tables()
	project = DB.Project.create({ "name": "Test" })


func attr(dict: Dictionary) -> Dictionary:
	var attributes = { "project_id": project.id }
	attributes.merge(dict, true)
	return attributes


func test_count_if_nothing():
	assert_eq(DB.Runner.count(), 0)


func test_new_record():
	var record = DB.Runner.new_record()
	assert_eq(DB.Runner.count(), 0)
	assert_eq(record.created_at, '')
	assert_eq(record.updated_at, '')


func test_set_timestamp():
	var record = DB.Runner.new_record()
	record.set_timestamp()
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_create():
	var record = DB.Runner.create(attr({ "path": "path/to/foo.bar" }))
	assert_eq(DB.Runner.count(), 1)
	assert_eq(record.path, 'path/to/foo.bar')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_first():
	DB.Runner.create(attr({ "path": "path/to/foo.bar" }))
	var record = DB.Runner.first()
	assert_eq(record.path, 'path/to/foo.bar')


func test_update():
	var record = DB.Runner.create(attr({ "path": "path/to/foo.bar", "created_at": "2025-01-02T03:04:05" }))
	record.update({ "path": "path/to/foo.bar2" })
	assert_eq(DB.Runner.count(), 1)
	record = DB.Runner.first()
	assert_eq(record.path, 'path/to/foo.bar2')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)
	assert_ne(record.created_at, record.updated_at)


func test_destroy():
	var record = DB.Runner.create(attr({ "path": "path/to/foo.bar" }))
	record.destroy()
	assert_eq(DB.Runner.count(), 0)


func test_all():
	DB.Runner.create(attr({ "path": "path/to/foo" }))
	DB.Runner.create(attr({ "path": "path/to/bar" }))
	var records = DB.Runner.all()
	assert_eq(records.size(), 2)


func test_where():
	DB.Runner.create(attr({ "path": "path/to/foo" }))
	DB.Runner.create(attr({ "path": "path/to/bar" }))
	var records = DB.Runner.where("project_id = %s" % project.id)
	assert_eq(records.size(), 2)
	records = DB.Runner.where("path LIKE '%foo'")
	assert_eq(records.size(), 1)


func test_delete_all():
	DB.Runner.create(attr({ "path": "path/to/foo" }))
	DB.Runner.create(attr({ "path": "path/to/bar" }))
	DB.Runner.delete_all()
	assert_eq(DB.Runner.count(), 0)


func test_start():
	pass # TODO
