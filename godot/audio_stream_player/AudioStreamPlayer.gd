

extends AudioStreamPlayer

var station

func _ready():
	station = get_parent()

func play_sound(sound : AudioStream):
	stream = sound
	play()
