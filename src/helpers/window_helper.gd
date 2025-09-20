extends Node
class_name WindowHelper


static func resize_with(node: Node, x: bool = true, y: bool = false) -> void:
	var window = node.get_window()
	var node_size = node.size * window.content_scale_factor
	if node.visible:
		if x: window.size.x += node_size.x
		if y: window.size.y += node_size.y
	else:
		if x: window.size.x -= node_size.x
		if y: window.size.y -= node_size.y


static func resize_x_with(node: Node) -> void:
	resize_with(node, true, false)


static func resize_y_with(node: Node) -> void:
	resize_with(node, false, true)
