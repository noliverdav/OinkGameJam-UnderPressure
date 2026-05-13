extends Interactable

var loadState := false
signal fireSignal(coordx_value, coordy_value, coordz_value)

@export var missile_mesh: Node3D
@export var Coor_x_Node: InteractuablePerilla
@export var Coor_Y_Node: InteractuablePerilla
@export var Coor_Z_Node: InteractuablePerilla

func interact(body):
	if not enabled or GameState.get_value("gabbedMissil") == false:
		return
	
	GameState.set_value("gabbedMissil", false)
	loadState = !loadState
	update_visual()

func update_visual():
	if missile_mesh:
		missile_mesh.visible = loadState
		
func fire(body):
	if not loadState:
		print("Cañon vacio camara no se mueve brr")
		return
	
	loadState = false
	
	var camera_node = body.find_child("Camera3D", true, false)
	if camera_node:
		var shaker = camera_node.get_node_or_null("CameraShaker") 
		if camera_node.has_method("shake"):
			camera_node.shake(0.8)
			
	fireSignal.emit(Coor_x_Node.current_degrees, Coor_Y_Node.current_degrees, Coor_Z_Node.current_degrees)
	update_visual()
