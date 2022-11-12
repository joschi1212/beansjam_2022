extends Node2D

onready var _area2d = $Area2D

export(String) var station_input_action = "station_a"
export(String) var station_input_label = "A"

func _ready():
	var key_input = $KeyInput
	key_input.set_station_input_action(station_input_label, station_input_action)
	key_input.connect("key_pressed", self, "_on_key_input_pressed")

func _on_key_input_pressed():
	print("Station Active")
	
#	if()
