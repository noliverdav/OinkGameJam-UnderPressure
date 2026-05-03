extends Interactable

var loadState := false;
@export var missile_mesh: Node3D

func interact(body):
	
	if not enabled or GameState.get_value("gabbedMissil")==false:
		return
	GameState.set_value("gabbedMissil", false)
	loadState = !loadState
	update_visual()


func update_visual():
	if missile_mesh:
		missile_mesh.visible = loadState
		
func fire():
	if not loadState:
		return
	#if door and door.is_open:
		#return
	loadState = false
	update_visual()
