extends PathFollow2D

onready var quarter_notes : int = 0
onready var eighth_notes : int = 0
onready var tacts : int = 0

onready var eighth_on_line_remaining = 0 setget set_eight_on_line_remaining

func _ready():
	Events.connect("quarter_note", self, "_on_quarter_note")
	Events.connect("eighth_note", self, "_on_eighth_note")
	Events.connect("new_tact", self, "_on_new_tact")
	Events.connect("item_enters_line", self, "_on_item_enters_line")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_offset(get_offset() + 50 * delta)

func _on_quarter_note():
	quarter_notes += 1
	$Sprite/QuarterNotesLabel.set_text(str(quarter_notes))

func _on_eighth_note():
	eighth_notes += 1
	eighth_on_line_remaining -= 1
	if(eighth_on_line_remaining == 0):
		Events.emit_signal("item_at_end_of_line", self)
	$Sprite/EighthNotesLabel.set_text(str(eighth_notes))

func _on_new_tact():
	tacts += 1
	$Sprite/TactsLabel.set_text(str(tacts))

func set_eight_on_line_remaining(length):
	eighth_on_line_remaining = length
