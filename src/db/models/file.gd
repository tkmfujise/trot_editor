extends DB_Table
func table_name() -> String: return 'files'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var project_id : int
	var path : String
	var created_at : String
	var updated_at : String
	func column_names(): return ['id', 'project_id', 'path', 'created_at', 'updated_at']

	func start() -> void:
		OS.create_process('open', [path])


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["project_id"] = {"data_type":"int", "foreign_key": "projects.id", "not_null": true}
	dict["path"] = {"data_type":"text", "not_null": true}
	dict["created_at"] = {"data_type":"text", "not_null": true}
	dict["updated_at"] = {"data_type":"text", "not_null": true}
	return dict
