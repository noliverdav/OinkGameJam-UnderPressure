extends Node
@export var enemy_scene: PackedScene
@export var spawn_interval := 5.0
@export var cannon: Node3D

var enemies_list: Array = []

func _ready():
	#You will have to add a reference to inventory node with @export or other method
	cannon.connect("fireSignal", cannonFiredCheckEnemies)

var spawn_timer := 0.0

func _process(delta):
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval and enemies_list.size()<3:
		spawn_enemy()
		spawn_timer = 0.0
	
func spawn_enemy():
	var enemyInstance = enemy_scene.instantiate()
	enemies_list.append(enemyInstance)
	add_child(enemyInstance)
	

	
func cannonFiredCheckEnemies(coordx,coordy):
	print("fire: ", coordx," - ",coordy)
	for enemy in enemies_list:
		if enemy.has_method("check_hit"):
			var hit = enemy.check_hit(coordx, coordy)
			if hit:
				enemies_list.erase(enemy)
				spawn_timer = 0
				break 
