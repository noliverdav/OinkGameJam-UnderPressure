extends Node

var state := {
	"health": 100,
	"key": 0,
	"gabbedMissil": false,
	"enemyCurrentWave":1,
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

func nextWave():
	var currentaWave = get_value("enemyCurrentWave")
	var nextWave = currentaWave+1
	set_value("enemyCurrentWave",  nextWave)

var player_node: Player = null

func take_damage(amount: int):
	var current_health = get_value("health", 100)
	var new_health = current_health - amount

	
	set_value("health", max(0, new_health))
	print(current_health)
	
	if new_health <= 0:
		print("Player Died!")
	if player_node:
		player_node.hurt(amount)


	
