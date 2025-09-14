extends DB_Table
func table_name() -> String: return 'projects'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var name : String
	var created_at : String
	var updated_at : String
	func column_names(): return ['id', 'name', 'created_at', 'updated_at']

	func find_or_build_hoofprint(date: String) -> DB_Record:
		var record = DB.Hoofprint.find("project_id = %s AND date = '%s'" % [id, date])
		if record: return record
		else: return DB.Hoofprint.new_record({
			"project_id": id,
			"date": date
		})

	func create_hoofprint(attributes: Dictionary) -> DB_Record:
		var params = { "project_id": id }
		attributes.merge(params)
		return DB.Hoofprint.create(attributes)

	func hoofprints() -> Array:
		return DB.Hoofprint.where("project_id = %s" % id)

	func hoofprints_count() -> int:
		return DB.Hoofprint.count("project_id = %s" % id)

	func hoofprints_duration() -> int:
		var sum = DB.Hoofprint.select('SUM(duration) AS duration',
			"project_id = %s" % id)[0]['duration']
		return sum if sum else 0


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["name"] = {"data_type":"text", "not_null": true}
	dict["created_at"] = {"data_type":"text", "not_null": true}
	dict["updated_at"] = {"data_type":"text", "not_null": true}
	return dict
