extends DB_Table
func table_name() -> String: return 'hoofprints'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var project_id : int
	var date : String
	var duration : int
	var created_at : String
	var updated_at : String
	func column_names(): return ['id', 'project_id', 'date', 'duration', 'created_at', 'updated_at']


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["project_id"] = {"data_type":"int", "foreign_key": "projects.id", "not_null": true}
	dict["date"] = {"data_type":"text", "not_null": true}
	dict["duration"] = {"data_type":"int", "not_null": true}
	dict["created_at"] = {"data_type":"text", "not_null": true}
	dict["updated_at"] = {"data_type":"text", "not_null": true}
	return dict
