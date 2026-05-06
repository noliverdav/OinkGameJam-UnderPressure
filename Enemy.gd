extends Node3D

var coordX:=0
var coordY:=0

func _ready() -> void:
	coordX = randi_range(-10, 10)
	coordY = randi_range(-10, 10)
	position = Vector3(coordX,0,coordY)
	print(coordX," - ",coordY)

func _on_timer_timeout():
	#enemigo ataca
	print("Repeating action triggered!")
	
func check_hit(tx, ty) -> bool:
	if tx == coordX and ty == coordY:
		queue_free()
		return true
	return false
