extends Interactable

@export var cannon: Node
@export var door: Escotilla
@export var click_sound: AudioStreamPlayer3D

func interact(body):
	if not enabled:
		return

	if click_sound:
		click_sound.play()
		
	if door and door.is_open:
		print("Puerta abierta")
		return
	
	if cannon and cannon.has_method("fire"):
		cannon.fire(body) 
		print("disparo")
