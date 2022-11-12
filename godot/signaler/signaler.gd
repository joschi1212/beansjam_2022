extends Node


func _ready():
	var _timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_timer_timeout")
	_timer.set_wait_time(2.0)
	_timer.set_one_shot(false)
	_timer.start()

func _on_timer_timeout():
	emit_signal("beat")
