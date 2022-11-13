extends Node


var eighth_note_duration = 0.125 # [sec]

var score = 0
var sword0_count = 0
var sword1_count = 0
var sword2_count = 0
var sword3_count = 0
var sword4_count = 0

func reset_score():
	score = 0
	sword0_count = 0
	sword1_count = 0
	sword2_count = 0
	sword3_count = 0
	sword4_count = 0

var time_left = 480 

func reset_time():
	time_left = 480
