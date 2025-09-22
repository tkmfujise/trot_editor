class_name DB_Record

var model : DB_Table
var new_record : bool = false
var errors : Array

func column_names() -> Array[String]:
	return [] # override this method


func identify_column() -> String:
	return 'id'


func identify_value():
	return get(identify_column())


func identify_condition() -> String:
	var condition_fields = [identify_column(), identify_value()]
	if not condition_fields.all(func(c): return c): return ''
	return "%s = %s" % condition_fields


func reload() -> bool:
	var condition = identify_condition()
	if not condition: return false
	var found_record = model.find(identify_condition())
	if not found_record: return false
	assign_attributes(found_record.attributes())
	new_record = false
	return true


func assign_attributes(_attributes: Dictionary) -> void:
	if not _attributes: return
	for column in column_names():
		if _attributes.has(column):
			set(column, _attributes[column])


func attributes() -> Dictionary:
	var dict = Dictionary()
	for column in column_names():
		dict[column] = get(column)
	return dict


func save() -> void:
	_validates()
	if errors: return
	if new_record: check_existence()
	if new_record: create()
	else: update()


func _validates() -> void:
	errors = []
	validates()


func validates() -> void:
	pass # Override this method


func create() -> void:
	set_timestamp()
	var dict = attributes()
	if not identify_value(): dict.erase(identify_column())
	var row_id = model.insert(dict)
	set(identify_column(), row_id)
	new_record = false


func update(_attributes: Dictionary = {}) -> void:
	if _attributes: assign_attributes(_attributes)
	var condition = identify_condition()
	if not condition:
		printerr('update keys lack')
		return
	set_timestamp()
	model.update(condition, attributes())


func destroy() -> void:
	model.delete(identify_condition())


func check_existence() -> bool:
	new_record = true
	var condition = identify_condition()
	if not condition: return false
	var record = model.find(identify_condition())
	if record: new_record = false
	return not new_record


func set_timestamp() -> void:
	var time = TimeHelper.now_str()
	for prop in get_property_list():
		match prop.name:
			'created_at': if not get('created_at'):
				set('created_at', time)
			'updated_at': set('updated_at', time)
