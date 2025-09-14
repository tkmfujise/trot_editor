extends Node
class_name ArrayHelper


static func reverse(origin: Array) -> Array:
	var arr = origin.duplicate()
	arr.reverse()
	return arr
