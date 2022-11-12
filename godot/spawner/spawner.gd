extends Node2D

export(NodePath) var assembly_line_out_path
var _assembly_line_out

var _item_scene = preload("res://item/item.tscn")

func _ready():
	_assembly_line_out = get_node(assembly_line_out_path)
	Events.connect("new_tact", self, "_on_new_tact")
	# add first item initially
	var item = _item_scene.instance() 
	_assembly_line_out.add_item_to_line(item)

func _on_new_tact():
	var item = _item_scene.instance() 
	_assembly_line_out.add_item_to_line(item)

