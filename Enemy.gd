extends Node3D

var coordX:=0
var coordY:=0
var alive:= true

func _ready() -> void:
	coordX = randi_range(-10, 10)
	coordY = randi_range(-10, 10)
	position = Vector3(coordX,0,coordY)

func _on_timer_timeout():
	#enemigo ataca
	print("Repeating action triggered!")
