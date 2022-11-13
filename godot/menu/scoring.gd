extends Node2D

onready var _start_button : TextureButton = $Control/TextureButton

func _ready():
	_start_button.connect("button_up", self, "_start_game")
	$Control/Score.set_text(str(Global.score))
	
	$Control/Sword0.set_text(str(Global.sword0_count))
	$Control/Sword1.set_text(str(Global.sword1_count))
	$Control/Sword2.set_text(str(Global.sword2_count))
	$Control/Sword3.set_text(str(Global.sword3_count))
	$Control/Sword4.set_text(str(Global.sword4_count))
	
	

func _start_game():
	Global.reset_score()
	Global.reset_time()
	get_tree().change_scene("res://main/main.tscn")
