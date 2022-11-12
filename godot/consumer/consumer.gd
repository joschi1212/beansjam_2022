extends Node2D

export(Array, NodePath) var assembly_lines_in

func _ready():
	for ali in assembly_lines_in:
		get_node(ali).connect("item_at_end_of_line", self, "_on_item_at_end_of_line")

func _on_item_at_end_of_line(item):
	item.get_parent().remove_child(item)
	add_child(item)
	
	# do stome stuff with item and add score
	
	item.queue_free()
