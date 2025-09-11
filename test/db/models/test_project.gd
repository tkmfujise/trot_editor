extends GutTestMeta


func before_each():
	DB.reopen("res://data/trot-test.db")
	DB.recreate_tables()


func test_count_if_nothing():
	assert_eq(DB.Project.count(), 0)


func test_new_record():
	var record = DB.Project.new_record()
	assert_eq(DB.Project.count(), 0)
	assert_eq(record.created_at, '')
	assert_eq(record.updated_at, '')


func test_set_timestamp():
	var record = DB.Project.new_record()
	record.set_timestamp()
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_create():
	var record = DB.Project.create({ "name": "Test" })
	assert_eq(DB.Project.count(), 1)
	assert_eq(record.name, 'Test')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_first():
	DB.Project.create({ "name": "Test" })
	var record = DB.Project.first()
	assert_eq(record.name, 'Test')


func test_update():
	var record = DB.Project.create({ "name": "Test", "created_at": "2025-01-02T03:04:05" })
	record.update({ "name": "Test2" })
	assert_eq(DB.Project.count(), 1)
	record = DB.Project.first()
	assert_eq(record.name, 'Test2')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)
	assert_ne(record.created_at, record.updated_at)


func test_destroy():
	var record = DB.Project.create({ "name": "Test" })
	record.destroy()
	assert_eq(DB.Project.count(), 0)


func test_all():
	DB.Project.create({ "name": "Foo" })
	DB.Project.create({ "name": "Boo" })
	var records = DB.Project.all()
	assert_eq(records.size(), 2)


func test_where():
	DB.Project.create({ "name": "Foo" })
	DB.Project.create({ "name": "Boo" })
	var records = DB.Project.where("name = 'Foo'")
	assert_eq(records.size(), 1)
	assert_eq(records[0].name, 'Foo')
	records = DB.Project.where("name LIKE '%oo'")
	assert_eq(records.size(), 2)


func test_delete_all():
	DB.Project.create({ "name": "Foo" })
	DB.Project.create({ "name": "Boo" })
	DB.Project.delete_all()
	assert_eq(DB.Project.count(), 0)
