extends Node3D
@export var state_key: String = "gabbedMissil"


func _ready():
	visible = GameState.get_value(state_key, false)
	GameState.value_changed.connect(_on_value_changed)


func _on_value_changed(key, value):
	if key == state_key:
		visible = value
