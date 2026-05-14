extends Node3D
@export var enemyManager: enemiesManager
@onready var anim= $AnimationPlayer
var current_anim := ""
@export var sound: AudioStreamPlayer3D


func _process(delta):
	if(enemyManager.Check_CleanEnemiesWave()):
		anim.play("Wave_Safe")
		if(sound and sound.playing):
			sound.stop()
		

	else:
		anim.play("WaveActive")
		if(sound and !sound.playing):
			sound.play()
	pass
	
