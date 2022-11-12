extends Node2D

onready var _area2d = $Area2D
onready var _work_duration_timer = $WorkDurationTimer

export(String) var station_input_action = "station_a"
export(String) var station_input_label = "A"

var _working = false

func _ready():
	var key_input = $KeyInput
	key_input.set_station_input_action(station_input_label, station_input_action)
	key_input.connect("key_pressed", self, "_on_key_input_pressed")
	
	_work_duration_timer.set_one_shot(true)
	_work_duration_timer.connect("timeout", self, "_on_workduration_timeout")

func _on_key_input_pressed():
	if _working:
		return
	
	for item_area in _area2d.get_overlapping_areas():
		var item = item_area.get_parent()
		item.start_next_step_upgrade()
	
	_working = true
	_work_duration_timer.set_wait_time(Global.eighth_note_duration)
	_work_duration_timer.start()

func _on_workduration_timeout():
	_working = false

