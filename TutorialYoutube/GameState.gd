extends Node

var state := {
	"health": 100,
	"key": 0,
	"gabbedMissil": false
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
	
