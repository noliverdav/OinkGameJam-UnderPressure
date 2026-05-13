extends Node3D

@onready var label =$Label3D
@export var showX:=false
@export var showY:=false
@export var showZ:=false
@export var enemyManager: enemiesManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateText()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateText()
	pass

func updateText():
	if enemyManager.getEnemySelected():
		if showX:
			label.text ="X: "+str(enemyManager.getEnemySelected().getCoord_X()) + "°"
		if showY:
			label.text = "Y: "+str(enemyManager.getEnemySelected().getCoord_Y()) + "°"
		if showZ:
			label.text = "D: "+str(enemyManager.getEnemySelected().getCoord_Z())
	else:
		label.text = ""
