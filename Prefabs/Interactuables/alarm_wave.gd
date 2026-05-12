extends Node3D
@export var enemyManager: enemiesManager
@onready var anim= $AnimationPlayer
var current_anim := ""


func _process(delta):
	if(enemyManager.Check_CleanEnemiesWave()):
		anim.play("Wave_Safe")
	else:
		anim.play("WaveActive")
	pass
