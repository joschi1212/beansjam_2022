extends PathFollow2D

onready var halve_notes : int = 0
onready var quarter_notes : int = 0
onready var tacts : int = 0


func _ready():
	Events.connect("halve_note", self, "_on_halve_note")
	Events.connect("quarter_note", self, "_on_quarter_note")
	Events.connect("new_tact", self, "_on_new_tact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_offset(get_offset() + 50 * delta)

func _on_halve_note():
	halve_notes += 1
	$Sprite/WholeTonesLabel.set_text(str(halve_notes))

func _on_quarter_note():
	quarter_notes += 1
	$Sprite/HalveTonesLabel.set_text(str(quarter_notes))
	
func _on_new_tact():
	tacts += 1
	$Sprite/TactsLabel.set_text(str(tacts))
