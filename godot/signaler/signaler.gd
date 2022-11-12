extends Node

export(int) var bpm = 30

func _ready():
	var _timer_whole_tone = Timer.new()
	var _timer_half_tone = Timer.new()
	var _timer_new_tact = Timer.new()
	add_child(_timer_whole_tone)
	add_child(_timer_half_tone)
	add_child(_timer_new_tact)
	
	_timer_whole_tone.connect("timeout", self, "_on_whole_tone_timeout")
	_timer_whole_tone.set_wait_time(bpm / 60.0)
	_timer_whole_tone.set_one_shot(false)
	
	_timer_half_tone.connect("timeout", self, "_on_halve_tone_timeout")
	_timer_half_tone.set_wait_time(bpm / 30.0)
	_timer_half_tone.set_one_shot(false)
	
	_timer_new_tact.connect("timeout", self, "_on_new_tact_timeout")
	_timer_new_tact.set_wait_time(bpm / 15.0)
	_timer_new_tact.set_one_shot(false)
	
	_timer_whole_tone.start()
	_timer_half_tone.start()
	_timer_new_tact.start()

func _on_whole_tone_timeout():
	Events.emit_signal("whole_tone")

func _on_halve_tone_timeout():
	Events.emit_signal("halve_tone")

func _on_new_tact_timeout():
	Events.emit_signal("new_tact")
