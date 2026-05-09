extends Interactable
class_name InteractuablePerilla
@export var step: int = 1
@export var min:=-10
@export var max:=10

@export var label: Label3D

var current_degrees: int = 0
var is_interacting: bool = false
var _internal_degrees: float = 0.0

func _ready() -> void:
	update_visual()

func _process(delta):
	if not is_interacting:
		return
	if Input.is_action_pressed("Increse_grades"):
		if _internal_degrees < max:
			_internal_degrees += step * delta * 10
	if Input.is_action_pressed("Decrese_grades"):
		if _internal_degrees > min:
			_internal_degrees -= step * delta * 10
	
	current_degrees = round(_internal_degrees)
	
	update_visual()

func get_prompt():
	if not enabled:
		return ""
	# base = prompt_message
	return "Reduce - Add\n[Q] [E]"

func interact(body):
	if not enabled:
		return
	is_interacting = true
	
func stop_interacting():
	is_interacting = false

func update_visual():
	if label:
		label.text = str(current_degrees) + "°"
