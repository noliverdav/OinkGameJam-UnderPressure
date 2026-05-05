extends Node
@export var enemy_scene: PackedScene
@export var spawn_interval := 5.0

var spawn_timer := 0.0

func _process(delta):
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_enemy()
		spawn_timer = 0.0
	
			
func spawn_enemy():
	var enemyInstance = enemy_scene.instantiate()
	add_child(enemyInstance)
