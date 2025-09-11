extends DB_Table
func table_name() -> String: return 'projects'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var name : String
	var created_at : String
	var updated_at : String
	func column_names(): return ['id', 'name', 'created_at', 'updated_at']


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["name"] = {"data_type":"text", "not_null": true}
	dict["created_at"] = {"data_type":"text", "not_null": true}
	dict["updated_at"] = {"data_type":"text", "not_null": true}
	return dict
