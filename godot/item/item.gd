extends PathFollow2D

var quarter_notes : int = 0
var eighth_notes : int = 0
var tacts : int = 0

var eighth_on_line_remaining = 0
var _unit_stepsize = 0.0

signal item_at_end_of_line(item)

onready var _upgrade_timer = $UpgradeTimer
var _upgrading = false
var _construction_level = 0

func _ready():
	Events.connect("quarter_note", self, "_on_quarter_note")
	Events.connect("eighth_note", self, "_on_eighth_note")
	Events.connect("new_tact", self, "_on_new_tact")
	
	_upgrade_timer.set_one_shot(true)
	_upgrade_timer.connect("timeout", self, "_on_workduration_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#set_unit_offset(lerp(get_unit_offset(), get_unit_offset() + _unit_stepsize, delta / _unit_stepsize))
	pass

func _on_quarter_note():
	quarter_notes += 1
	$Sprite/QuarterNotesLabel.set_text(str(quarter_notes))

func _on_eighth_note():
	eighth_notes += 1

	$Sprite/StepsLeftLabel.set_text(str(eighth_on_line_remaining))
	if(eighth_on_line_remaining == 0):
		emit_signal("item_at_end_of_line", self)
	$Sprite/EighthNotesLabel.set_text(str(eighth_notes))
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
	tacts += 1
	$Sprite/TactsLabel.set_text(str(tacts))

func set_eighth_on_line_remaining(length):
	eighth_on_line_remaining = length
	_unit_stepsize = 1.0 / length
	set_unit_offset(0.0)
	$Sprite/StepsLeftLabel.set_text(str(eighth_on_line_remaining))

func start_next_step_upgrade():
	if _upgrading:
		return
	
	print("Upgrading")
	$Sprite/ConstructionLevelLabel.set_text(".")
	
	_upgrading = true
	_upgrade_timer.set_wait_time(2 * Global.eighth_note_duration)
	_upgrade_timer.start()

func _on_workduration_timeout():
	print("Done upgrading")
	
	_construction_level += 1
	_upgrading = false
	
	$Sprite/ConstructionLevelLabel.set_text(str(_construction_level))

