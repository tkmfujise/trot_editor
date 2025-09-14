extends GutTestMeta


func before_each():
	setup_db()


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


func test_find_or_build_hoofprint_new():
	var project = DB.Project.create({ "name": "Foo" })
	var hoofprint = project.find_or_build_hoofprint('2025-01-02')
	assert_not_null(hoofprint)
	assert_eq(hoofprint.project_id, project.id)
	assert_eq(hoofprint.date, '2025-01-02')
	assert_eq(DB.Hoofprint.count(), 0)


func test_find_or_build_hoofprint_existence():
	var project = DB.Project.create({ "name": "Foo" })
	DB.Hoofprint.create({ "project_id": project.id, "date": "2025-01-02" })
	var hoofprint = project.find_or_build_hoofprint('2025-01-02')
	assert_not_null(hoofprint)
	assert_eq(hoofprint.project_id, project.id)
	assert_eq(hoofprint.date, '2025-01-02')
	assert_eq(DB.Hoofprint.count(), 1)


func test_create_hoofprint():
	var project = DB.Project.create({ "name": "Foo" })
	var hoofprint = project.create_hoofprint({ "date": "2025-01-02", "duration": 2 })
	assert_eq(DB.Hoofprint.count(), 1)
	assert_eq(hoofprint.project_id, project.id)
	assert_eq(hoofprint.duration, 2)


func test_hoofprints():
	var project = DB.Project.create({ "name": "Foo" })
	project.create_hoofprint({ "date": "2025-01-01", "duration": 1 })
	project.create_hoofprint({ "date": "2025-01-02", "duration": 2 })
	assert_eq(project.hoofprints().size(), 2)


func test_hoofprints_count_if_none():
	var project = DB.Project.create({ "name": "Foo" })
	assert_eq(project.hoofprints_count(), 0)


func test_hoofprints_count_if_any():
	var project = DB.Project.create({ "name": "Foo" })
	project.create_hoofprint({ "date": '2025-01-01' })
	project.create_hoofprint({ "date": '2025-01-02' })
	assert_eq(project.hoofprints_count(), 2)


func test_hoofprints_duration_if_none():
	var project = DB.Project.create({ "name": "Foo" })
	assert_eq(project.hoofprints_duration(), 0)


func test_hoofprints_duration_if_any():
	var project = DB.Project.create({ "name": "Foo" })
	project.create_hoofprint({ 'date': '2025-01-01', 'duration': 1 })
	project.create_hoofprint({ 'date': '2025-01-02', 'duration': 2 })
	assert_eq(project.hoofprints_count(), 2)
	assert_eq(project.hoofprints_duration(), 3)
