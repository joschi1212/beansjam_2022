extends Node2D

onready var _start_button : TextureButton = $Control/TextureButton

func _ready():
	_start_button.connect("button_up", self, "_start_game")

func _start_game():
	get_tree().change_scene("res://main/main.tscn")
