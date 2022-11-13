extends Node2D

func _ready():
	var game_timer = Timer.new()
	add_child(game_timer)
	
	game_timer.connect("timeout", self, "_on_game_timer")
	game_timer.set_wait_time(0.25)
	game_timer.set_one_shot(false)
	
	game_timer.start()

func _on_game_timer():
	Global.time_left = max(Global.time_left - 1, 0)
	
	if Global.time_left == 0:
		get_tree().change_scene("res://menu/scoring.tscn")
		pass
	
	Events.emit_signal("time_update")
