extends Node

@export var steps:Array[AudioStreamPlayer] = []

func _ready() -> void:
	play_bgM()

func play_bgM():
	$AudioListener2D/Music.play()	
func play_Enemy_hit_1():
	$AudioListener2D/Enemy_hit_1.play()
func play_Enemy_hit_2():
	$AudioListener2D/Enemy_hit_2.play()

var step
func playRandomStep():
	if steps.is_empty():
		return
	for player in steps:
		if player.playing:
			return
		
	var random_index = randi() % steps.size()
	var step = steps[random_index]
	
	step.play()
