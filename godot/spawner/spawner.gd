extends Node2D

export(NodePath) var assembly_line_out_path
var _assembly_line_out

var _item_scene = preload("res://item/item.tscn")

func _ready():
	_assembly_line_out = get_node(assembly_line_out_path)
	Events.connect("new_tact", self, "_on_new_tact")

func _on_new_tact():
	_assembly_line_out.add_item_to_line(_item_scene.instance())

