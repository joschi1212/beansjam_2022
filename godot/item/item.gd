extends PathFollow2D

var eighth_on_line_remaining = 0
var _unit_stepsize = 0.0

signal item_at_end_of_line(item)

onready var _upgrade_timer = $UpgradeTimer
var _upgrading = false
var construction_level = 0

onready var _sword_sprites : AnimatedSprite = $Swords

func _ready():
	Events.connect("quarter_note", self, "_on_quarter_note")
	Events.connect("eighth_note", self, "_on_eighth_note")
	Events.connect("new_tact", self, "_on_new_tact")
	
	_upgrade_timer.set_one_shot(true)
	_upgrade_timer.connect("timeout", self, "_on_workduration_timeout")
	
	_sword_sprites.connect("animation_finished", self, "_on_animation_finished")

func _process(delta):
	pass

func _on_quarter_note():
	pass

func _on_eighth_note():
	_sword_sprites.set_speed_scale(2 / Global.eighth_note_duration)
	_sword_sprites.play()
	
	if(eighth_on_line_remaining == 0):
		emit_signal("item_at_end_of_line", self)
	if(eighth_on_line_remaining > 0):
		# move item
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_property(self, "unit_offset", get_unit_offset(), 
		get_unit_offset() + _unit_stepsize, Global.eighth_note_duration, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		
	eighth_on_line_remaining -= 1

func _on_new_tact():
	pass

func set_eighth_on_line_remaining(length):
	eighth_on_line_remaining = length
	_unit_stepsize = 1.0 / length
	set_unit_offset(0.0)

func start_next_step_upgrade():
	if _upgrading:
		return
	
	construction_level += 1
	_sword_sprites.set_animation("level" + str(construction_level))
	
	_upgrading = true
	_upgrade_timer.set_wait_time(2 * Global.eighth_note_duration)
	_upgrade_timer.start()

func _on_workduration_timeout():
	_upgrading = false

func _on_animation_finished():
	_sword_sprites.stop()

