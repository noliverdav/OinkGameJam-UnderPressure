extends Interactable

var loadState := false;
signal fireSignal(coordx_value,coordy_value,coordz_value)

@export var missile_mesh: Node3D
@export var Coor_x_Node: InteractuablePerilla
@export var Coor_Y_Node: InteractuablePerilla
@export var Coor_Z_Node: InteractuablePerilla

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
	#if Coor_x_Node and Coor_Y_Node:
		#print(Coor_x_Node.current_degrees);
	#if door and door.is_open:
		#return
	loadState = false
	fireSignal.emit(Coor_x_Node.current_degrees,Coor_Y_Node.current_degrees,Coor_Z_Node.current_degrees)
	update_visual()
