extends PathFollow2D

onready var beat : int = 0

func _ready():
	Events.connect("beat", self, "_on_beat")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_offset(get_offset() + 50 * delta)

func _on_beat():
	beat += 1
	$Sprite/Label.set_text(str(beat))
