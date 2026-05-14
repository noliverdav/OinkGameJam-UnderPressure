extends Node

var state := {
	"health": 100,
	"key": 0,
	"gabbedMissil": false,
	"enemyCurrentWave":0,
	"enemyMaxWave":20
}


func has_value(key):
	return state.has(key)

func get_value(key, default_value = null):
	if state.has(key):
		return state[key]
	
	return default_value
	
func set_value(key, value):
	state[key] = value
	value_changed.emit(key, value)
	
signal value_changed(key, value)

var player_UI: Player_UI = null

func waveActive(a:bool):
	player_UI.TonggleTimer(a)

func nextWave():
	var currentaWave = get_value("enemyCurrentWave")
	var nextWave = currentaWave+1
	set_value("enemyCurrentWave",  nextWave)
	player_UI._updateEnemyWave(nextWave,get_value("enemyMaxWave"))
	
#func Wave_Timer(_timer: int):
#	player_UI._updateEnemyWave_Timer(_timer)

var player_node: Player = null

func take_damage(amount: int):
	var current_health = get_value("health", 100)
	var new_health = current_health - amount

	
	set_value("health", max(0, new_health))
	print(new_health)
	
	if new_health <= 0:
		print("Player Died!")
	if player_node:
		player_node.hurt(amount)
		

func playSound_by_healt():
	AudioController.playSound_health()


	
