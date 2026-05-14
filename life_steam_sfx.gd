extends AudioStreamPlayer3D

@export var life_to_activate:int

func _ready():
	GameState.value_changed.connect(_on_global_value_changed)

func _on_global_value_changed(key, value):
	if key == "health":
		if value <= life_to_activate:
			play()
