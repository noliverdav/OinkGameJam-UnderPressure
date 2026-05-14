extends Node3D
class_name Enemy

var coordX:=0
var coordY:=0
var coorDistance :=0
var selectedInMinimap:bool
@export var label: Label3D

@export var materialSelected:Material;
@export var materialUnselected:Material;



func _ready() -> void:
	coordX = randi_range(-10, 10)
	coordY = randi_range(-10, 10)
	coorDistance = randi_range(0, 20)
	position = Vector3(coordX,0,coordY)
	if label:
		label.text = "("+str(coordX) + " , "+str(coordY)+","+str(coorDistance)+ ")"
	ChangeColorSelected();
	
func check_hit(tx, ty, td) -> bool:
	if tx == coordX and ty == coordY and td == coorDistance:
		return true
	return false
	
func Destroy():
	queue_free()

func _on_attack_timer_timeout() -> void:
	#pass # Replace with function body.
	GameState.take_damage(25)
	AudioController.play_Enemy_hit_1()

func Set_selectedEnemy(a:bool):
	selectedInMinimap = a
	ChangeColorSelected()

func get_selectedEnemy() -> bool:
	return selectedInMinimap
	
func ChangeColorSelected():
	var material = $MeshInstance3D.get_active_material(0)
	if(get_selectedEnemy()):
		$MeshInstance3D.set_surface_override_material(0, materialSelected)	
	else:
		$MeshInstance3D.set_surface_override_material(0, materialUnselected)
		


func getCoord_X()-> int:
	return coordX
func getCoord_Y()-> int:
	return coordY
func getCoord_Z()-> int:
	return coorDistance
