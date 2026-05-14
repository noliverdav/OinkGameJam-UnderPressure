extends Node3D

@export var enemyManager: enemiesManager
@onready var anim = $AnimationPlayer

func _process(delta):
	if enemyManager.Check_CleanEnemiesWave():
		visible = true
		anim.play("Wave_Safe")
	else:
		visible = false
		anim.stop()
