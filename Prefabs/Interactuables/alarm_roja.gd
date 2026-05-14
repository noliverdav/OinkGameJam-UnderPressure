extends Node3D

@export var enemyManager: enemiesManager
@export var sound: AudioStreamPlayer3D
@onready var anim = $AnimationPlayer

func _process(delta):
	if enemyManager.Check_CleanEnemiesWave():
		visible = false
		anim.stop()
		if sound and sound.playing:
			sound.stop()
	else:
		visible = true
		anim.play("WaveActive")
		if sound and !sound.playing:
			sound.play()
