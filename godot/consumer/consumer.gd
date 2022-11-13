extends Node2D

export(Array, NodePath) var assembly_lines_in

func _ready():
	for ali in assembly_lines_in:
		get_node(ali).connect("item_at_end_of_line", self, "_on_item_at_end_of_line")

func _on_item_at_end_of_line(item):
	item.get_parent().remove_child(item)
	add_child(item)
	
	if item.construction_level == 0:
		Global.score += 0
		Global.sword0_count += 1
	if item.construction_level == 1:
		Global.score += 10
		Global.sword1_count += 1
	if item.construction_level == 2:
		Global.score += 20
		Global.sword2_count += 1
	if item.construction_level == 3:
		Global.score += 30
		Global.sword3_count += 1
	if item.construction_level == 4:
		Global.score += 40
		Global.sword4_count += 1
	
	item.queue_free()
	
	Events.emit_signal("score_update")
