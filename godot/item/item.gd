extends PathFollow2D

onready var whole_tones : int = 0
onready var halve_tones : int = 0
onready var tacts : int = 0


func _ready():
	Events.connect("whole_tone", self, "_on_whole_tone")
	Events.connect("halve_tone", self, "_on_halve_tone")
	Events.connect("new_tact", self, "_on_new_tact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_offset(get_offset() + 50 * delta)

func _on_whole_tone():
	whole_tones += 1
	$Sprite/WholeTonesLabel.set_text(str(whole_tones))

func _on_halve_tone():
	halve_tones += 1
	$Sprite/HalveTonesLabel.set_text(str(halve_tones))
	
func _on_new_tact():
	tacts += 1
	$Sprite/TactsLabel.set_text(str(tacts))
