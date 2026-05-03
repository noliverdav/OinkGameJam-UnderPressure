extends Interactable

var loadState := false;
@export var missile_mesh: Node3D

func interact(body):
	if not enabled:
		return
	
	loadState = !loadState
	update_visual()


func update_visual():
	if missile_mesh:
		missile_mesh.visible = loadState
