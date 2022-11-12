extends Node2D

export(NodePath) var assembly_line_in

func _ready():
	get_node(assembly_line_in).connect("item_at_end_of_line", self, "_on_item_at_end_of_line")

func _on_item_at_end_of_line(item):
	add_child(item)
	
	# do stome stuff with item and add score
	
	item.queue_free()
