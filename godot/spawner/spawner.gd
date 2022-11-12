extends Node2D

export(PackedScene) var assembly_line_out

var _item_scene = preload("res://item/item.tscn")

func _ready():
	Events.connect("new_tact", self, "_on_new_tact")

func _on_new_tact():
	var item = _item_scene.instance() 
	assembly_line_out.add_item_to_line(item)

