extends Label3D
@export var enemiesManager: enemiesManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(enemiesManager.getWaveTimeLeft())
	TonggleTimer(enemiesManager.Check_CleanEnemiesWave())
	pass
	
func TonggleTimer(a: bool):
	self.visible = a
