class_name DB_Table


class Record extends DB_Record: pass


func table_name() -> String: # override this method
	return ''


func schema() -> Dictionary: # override this method
	var dict = Dictionary()
	#dict["id"] = {"data_type":"int", "primary_key": true, "not_null": true}
	#dict["name"] = {"data_type":"text", "not_null": true}
	#dict["age"] = {"data_type":"int", "not_null": true}
	return dict


func recreate_table() -> void:
	DB.conn.drop_table(table_name())
	DB.conn.create_table(table_name(), schema())


func all() -> Array:
	return where('')


func where(condition: String) -> Array:
	return DB.conn.select_rows(table_name(), condition, ['*']).map(
		func(params): return recordize(params))


func find(condition: String):
	var result = where(condition)
	if not result: return null
	else: return result[0]


func first(limit: int = 1, params : Dictionary = {}):
	var str := 'SELECT * FROM "%s" WHERE %s ORDER BY %s LIMIT %s'
	var cond  = params['condition'] if params.has('condition') else '1=1'
	var order = params['order'] if params.has('order') else '"id" ASC'
	var query := [table_name(), cond, order, limit]
	DB.conn.query(str % query)
	var result = DB.conn.query_result.map(
		func(params): return recordize(params))
	if result:
		return result[0] if limit == 1 else result
	else:
		return null if limit == 1 else []


func last(limit: int = 1):
	var result = first(limit, { "order": '"id" DESC' })
	if typeof(result) == TYPE_ARRAY: result.reverse()
	return result


func recordize(params: Dictionary):
	return params # override this method


func recordize_by(klass, params: Dictionary) -> Variant:
	var record = klass.new()
	record.model = self
	record.new_record = not params.has('id')
	record.assign_attributes(params)
	return record


func new_record():
	return recordize({})


func insert(attributes: Dictionary) -> int:
	DB.conn.insert_row(table_name(), attributes)
	return DB.conn.get_last_insert_rowid()


func create(attributes: Dictionary) -> DB_Record:
	var record = recordize(attributes)
	record.create()
	return record


func update(condition: String, attributes: Dictionary) -> void:
	DB.conn.update_rows(table_name(), condition, attributes)


func delete(condition: String) -> void:
	DB.conn.delete_rows(table_name(), condition)


func delete_all() -> void:
	delete('')


func count(condition: String = '1=1') -> int:
	DB.conn.query(
		'SELECT count(*) as cnt FROM %s WHERE %s' %
		[table_name(), condition])
	return DB.conn.query_result[0]['cnt']
