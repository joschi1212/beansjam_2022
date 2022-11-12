extends Node

export(int) var bpm = 30
var bps = bpm / 60.0

func _ready():
	var _timer_quarter_note = Timer.new()
	var _timer_eighth_note = Timer.new()
	var _timer_new_tact = Timer.new()
	add_child(_timer_quarter_note)
	add_child(_timer_eighth_note)
	add_child(_timer_new_tact)
	
	_timer_eighth_note.connect("timeout", self, "_on_eighth_note_timeout")
	_timer_eighth_note.set_wait_time(0.5 / bps)
	_timer_eighth_note.set_one_shot(false)
	
	_timer_quarter_note.connect("timeout", self, "_on_quarter_note_timeout")
	_timer_quarter_note.set_wait_time(1.0 / bps)
	_timer_quarter_note.set_one_shot(false)
	
	_timer_new_tact.connect("timeout", self, "_on_new_tact_timeout")
	_timer_new_tact.set_wait_time(4.0 / bps)
	_timer_new_tact.set_one_shot(false)
	
	_timer_quarter_note.start()
	_timer_eighth_note.start()
	_timer_new_tact.start()
	
	Events.emit_signal("quarter_note")
	Events.emit_signal("eighth_note")
	Events.emit_signal("new_tact")

func _on_quarter_note_timeout():
	Events.emit_signal("quarter_note")

func _on_eighth_note_timeout():
	Events.emit_signal("eighth_note")

func _on_new_tact_timeout():
	Events.emit_signal("new_tact")
