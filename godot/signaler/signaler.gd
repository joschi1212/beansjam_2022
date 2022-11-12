extends Node

export(int) var bpm = 30

func _ready():
	var _timer_half_note = Timer.new()
	var _timer_quarter_note = Timer.new()
	var _timer_new_tact = Timer.new()
	add_child(_timer_half_note)
	add_child(_timer_quarter_note)
	add_child(_timer_new_tact)
	
	_timer_half_note.connect("timeout", self, "_on_halve_note_timeout")
	_timer_half_note.set_wait_time(bpm / 60.0)
	_timer_half_note.set_one_shot(false)
	
	_timer_quarter_note.connect("timeout", self, "_on_quarter_note_timeout")
	_timer_quarter_note.set_wait_time(bpm / 30.0)
	_timer_quarter_note.set_one_shot(false)
	
	_timer_new_tact.connect("timeout", self, "_on_new_tact_timeout")
	_timer_new_tact.set_wait_time(bpm / 15.0)
	_timer_new_tact.set_one_shot(false)
	
	_timer_half_note.start()
	_timer_quarter_note.start()
	_timer_new_tact.start()

func _on_halve_note_timeout():
	Events.emit_signal("halve_note")

func _on_quarter_note_timeout():
	Events.emit_signal("quarter_note")

func _on_new_tact_timeout():
	Events.emit_signal("new_tact")
