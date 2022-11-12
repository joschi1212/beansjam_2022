extends AudioStreamPlayer

func _ready():
	Events.connect("eighth_note", self, "_on_eighth_note")
	


func _on_eighth_note():
	self.play()
