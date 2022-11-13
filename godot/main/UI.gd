extends Control


func _ready():
	Events.connect("score_update", self, "_on_score_update")
	Events.connect("time_update", self, "_on_time_update")

func _on_score_update():
	$SwordCount.set_text(str(Global.score))

func _on_time_update():
	var hours = int(Global.time_left / 60)
	var minutes = Global.time_left % 60
	
	var m_str = str(minutes)
	if minutes < 10:
		m_str = "0" + m_str
	
	$Time.set_text(str(hours) + ":" + m_str)
