extends Node3D

var coordX:=0
var coordY:=0
var coorDistance :=0
@export var label: Label3D

func _ready() -> void:
	coordX = randi_range(-10, 10)
	coordY = randi_range(-10, 10)
	coorDistance = randi_range(0, 20)
	position = Vector3(coordX,0,coordY)
	if label:
		label.text = "("+str(coordX) + " , "+str(coordY)+","+str(coorDistance)+ ")"
	
func check_hit(tx, ty, td) -> bool:
	if tx == coordX and ty == coordY and td == coorDistance:
		return true
	return false
	
func Destroy():
	queue_free()

#tomado desde Signals
func _on_attack_timer_timeout() -> void:
	pass # Replace with function body.
	GameState.take_damage(10) 
