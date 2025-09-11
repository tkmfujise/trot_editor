extends Node
class_name TimeHelper


static func now() -> Dictionary:
	var dict = Time.get_datetime_dict_from_system()
	dict.erase('dst')
	return dict

static func now_unix() -> int:
	return Time.get_unix_time_from_system()


static func now_str() -> String:
	return Time.get_datetime_string_from_system()


static func unix2dict(unix_time) -> Dictionary:
	return Time.get_datetime_dict_from_unix_time(unix_time)


static func unix2str(unix_time) -> String:
	return Time.get_datetime_string_from_unix_time(unix_time)


static func dict2unix(dict) -> int:
	return Time.get_unix_time_from_datetime_dict(dict)


static func dict2str(dict) -> String:
	return Time.get_datetime_string_from_datetime_dict(dict, false)


static func str2unix(str) -> int:
	return Time.get_unix_time_from_datetime_string(str)


static func str2dict(str) -> Dictionary:
	return Time.get_datetime_dict_from_datetime_string(str, true)
