extends Interactable
@export var cannon: Node
@export var door: Escotilla

func interact(body):
	if not enabled:
		return
		
	if door and door.is_open:
		print("Puerta abierta")
		return
	
	if cannon and cannon.has_method("fire"):
		cannon.fire()
	
