extends Node2D

var itemScene = preload("res://item/item.tscn")

onready var assemblyLine1 = $AssemblyLine1
onready var assemblyLine2 = $AssemblyLine2

func _ready():
	assemblyLine1.add_child(itemScene.instance())
	assemblyLine2.add_child(itemScene.instance())

