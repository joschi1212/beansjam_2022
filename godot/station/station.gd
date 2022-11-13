extends Node2D

onready var _area2d = $Area2D
onready var _work_duration_timer = $WorkDurationTimer
onready var _key_input = $KeyInput
onready var _wizard_sprite : AnimatedSprite = $AnimatedSprite

export(String) var station_input_action = "station_a"
export(String) var station_input_label = "A"
export(AudioStream) var wrong_sound: AudioStream
export(AudioStream) var success_sound: AudioStream

export var play_sound : bool = true
export var play_wrong_sound : bool = true

enum Direction {left, right, bottom}
export(Direction) var direction = Direction.bottom

var _working = false

var audio_player

func _ready():
	_key_input.set_station_input_action(station_input_label, station_input_action)
	_key_input.connect("key_pressed", self, "_on_key_input_pressed")
	
	_work_duration_timer.set_one_shot(true)
	_work_duration_timer.connect("timeout", self, "_on_workduration_timeout")
	audio_player = $AudioStreamPlayer
	
	match direction:
		Direction.left:
			_wizard_sprite.set_animation("side")
			_wizard_sprite.set_flip_h(true)
		Direction.right:
			_wizard_sprite.set_animation("side")
		Direction.bottom:
			_wizard_sprite.set_animation("bottom")

func _on_key_input_pressed():
	if _working:
		return
	
	if(self.is_in_group("bassStations")):
		var all_empty = true
		for bassStation in get_tree().get_nodes_in_group("bassStations"):
			if not bassStation._area2d.get_overlapping_areas().empty():
				all_empty = false
		if all_empty and play_wrong_sound:
			audio_player.play_sound(wrong_sound)
	else:
		if play_wrong_sound and _area2d.get_overlapping_areas().empty():
			audio_player.play_sound(wrong_sound)
	
	for item_area in _area2d.get_overlapping_areas():
		var item = item_area.get_parent()
		item.start_next_step_upgrade()
		if play_sound:
			audio_player.play_sound(success_sound)
	
	_working = true
	_work_duration_timer.set_wait_time(Global.eighth_note_duration)
	_work_duration_timer.start()

func _on_workduration_timeout():
	_working = false

