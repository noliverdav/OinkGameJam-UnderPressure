extends Node
class_name enemiesManager
@export var enemy_scene: PackedScene
@export var spawn_interval := 10.0
@export var time_until_next_wave := 10.0
var wave_timer := 0.0 

@export var cannon: Node3D
var enemiesLimiter:=1
var spawnedEnemiesCounter:=0

var enemies_list: Array = []
@onready var coordsMinimap =$EnemyCoords

func _ready():
	cannon.connect("fireSignal", cannonFiredCheckEnemies)
	spawnedEnemiesCounter = enemiesLimiter

var spawn_timer := 0.0

func _process(delta):
	checkEnemySelected()
	
	if Check_CleanEnemiesWave():
		nextWaveTimer(delta)
	else:
		spawn_timer += delta
		
		if spawn_timer >= spawn_interval and enemies_list.size()<enemiesLimiter and spawnedEnemiesCounter>0:
			spawn_enemy()
			spawn_timer = 0.0
		
	
func spawn_enemy():
	spawnedEnemiesCounter-=1
	var enemyInstance = enemy_scene.instantiate()
	enemies_list.append(enemyInstance)
	add_child(enemyInstance)
	
func checkWave_IncreaseEnemies():
	if GameState.get_value("enemyCurrentWave")>=0:
		enemiesLimiter=1
	if GameState.get_value("enemyCurrentWave")>=5:
		enemiesLimiter=2
	if GameState.get_value("enemyCurrentWave")>=15:
		enemiesLimiter=3
	spawnedEnemiesCounter = enemiesLimiter

func checkEnemySelected():
	var oneEnemySelected = false
	for enemy in enemies_list:
		if(enemy.get_selectedEnemy()):
			oneEnemySelected = true;
			coordsMinimap.text = "("+str(enemy.getCoord_X()) + " , "+str(enemy.getCoord_Y())+","+str(enemy.getCoord_Z())+ ")"
			break
	if(!oneEnemySelected):
		coordsMinimap.text = ""
	
func cannonFiredCheckEnemies(coordx,coordy,coordz):
	print("fire: ", coordx," - ",coordy, " - ", coordz)
	for enemy in enemies_list:
		
		if enemy.has_method("check_hit"):
			var hit = enemy.check_hit(coordx, coordy,coordz)
			
			if hit:
				enemies_list.erase(enemy)
				enemy.Destroy()
				spawn_timer = 0
				#Check_CleanEnemiesWave()
				break

func nextWaveTimer(delta):
	wave_timer += delta
	if wave_timer >= time_until_next_wave:
		Start_Next_Wave()
		wave_timer = 0.0 

func Check_CleanEnemiesWave() -> bool:
	return enemies_list.is_empty() and spawnedEnemiesCounter<=0
		
func Start_Next_Wave():
	GameState.nextWave()
	checkWave_IncreaseEnemies()
	spawn_timer =spawn_interval

#func _input(event: InputEvent) -> void:
#	if minimapCamera.current:
#		if event is InputEventMouseMotion:
#			head.rotate_z(deg_to_rad(-event.relative.x * 0.002))
#			head.rotate_x(deg_to_rad(-event.relative.y * 0.002))

#var playerCamera:Camera3D
#@export var minimapCamera:Camera3D
#func _on_area_3d_body_entered(body: Node3D) -> void:
#	playerCamera = get_viewport().get_camera_3d()
#	if minimapCamera:
#		minimapCamera.make_current()
	
#func _on_area_3d_body_exited(body: Node3D) -> void:
#	if playerCamera:
#		playerCamera.make_current()
