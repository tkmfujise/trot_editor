extends GutTestMeta

var project

func before_each():
	setup_db()
	project = DB.Project.create({ "name": "Test" })


func attr(dict: Dictionary) -> Dictionary:
	var attributes = { "project_id": project.id, "duration": 3600, "date": "2025-01-02" }
	attributes.merge(dict, true)
	return attributes


func test_count_if_nothing():
	assert_eq(DB.Hoofprint.count(), 0)


func test_new_record():
	var record = DB.Hoofprint.new_record()
	assert_eq(DB.Hoofprint.count(), 0)
	assert_eq(record.created_at, '')
	assert_eq(record.updated_at, '')


func test_set_timestamp():
	var record = DB.Hoofprint.new_record()
	record.set_timestamp()
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_create():
	var record = DB.Hoofprint.create(attr({ "date": "2025-01-02", "duration": 123456789 }))
	assert_eq(DB.Hoofprint.count(), 1)
	assert_eq(record.date, '2025-01-02')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)


func test_first():
	DB.Hoofprint.create(attr({ "duration": 123456789 }))
	var record = DB.Hoofprint.first()
	assert_eq(record.duration, 123456789)


func test_update():
	var record = DB.Hoofprint.create(attr({ "date": "2025-01-02", "created_at": "2025-01-02T03:04:05" }))
	record.update({ "date": "2025-01-02" })
	assert_eq(DB.Hoofprint.count(), 1)
	record = DB.Hoofprint.first()
	assert_eq(record.date, '2025-01-02')
	assert_match_time_str(record.created_at)
	assert_match_time_str(record.updated_at)
	assert_ne(record.created_at, record.updated_at)


func test_destroy():
	var record = DB.Hoofprint.create(attr({ "date": "2025-01-02" }))
	record.destroy()
	assert_eq(DB.Hoofprint.count(), 0)


func test_all():
	DB.Hoofprint.create(attr({ "date": "2025-01-02" }))
	DB.Hoofprint.create(attr({ "date": "2025-02-03" }))
	var records = DB.Hoofprint.all()
	assert_eq(records.size(), 2)


func test_where():
	DB.Hoofprint.create(attr({ "date": "2025-01-02" }))
	DB.Hoofprint.create(attr({ "date": "2025-02-03" }))
	var records = DB.Hoofprint.where("project_id = %s" % project.id)
	assert_eq(records.size(), 2)
	records = DB.Hoofprint.where("date LIKE '%2025-01%'")
	assert_eq(records.size(), 1)


func test_delete_all():
	DB.Hoofprint.create(attr({ "date": "2025-01-02" }))
	DB.Hoofprint.create(attr({ "date": "2025-02-03" }))
	DB.Hoofprint.delete_all()
	assert_eq(DB.Hoofprint.count(), 0)
