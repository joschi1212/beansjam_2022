extends Node2D

var _station_input_action = "station_a"

signal key_pressed

func _input(event):
	if event.is_action_pressed(_station_input_action):
		emit_signal("key_pressed")

func set_station_input_action(label : String , action : String):
	$KeyInfo.set_text(label)
	_station_input_action = action

