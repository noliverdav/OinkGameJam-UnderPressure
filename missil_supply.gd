extends Interactable

func _ready():
	interacted.connect(_on_interacted)

func _on_interacted(_body):
	if GameState.get_value("gabbedMissil")==false:
		GameState.set_value("gabbedMissil", true)
