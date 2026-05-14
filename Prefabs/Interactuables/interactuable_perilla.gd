extends Interactable
class_name InteractuablePerilla
@export var step: int = 1
@export var min:=-10
@export var max:=10
@export var show_degree_in_text:=true
@export var coordText=""

@export var label: Label3D
@onready var PerillaMesh := $MeshInstance3D

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
			if!$AudioStreamPlayer3D.playing:
				$AudioStreamPlayer3D.play()

			
	if Input.is_action_pressed("Decrese_grades"):
		if _internal_degrees > min:
			_internal_degrees -= step * delta * 10
			if!$AudioStreamPlayer3D.playing:
				$AudioStreamPlayer3D.play()

	if Input.is_action_just_released("Decrese_grades") or Input.is_action_just_released("Increse_grades") or current_degrees == min or current_degrees == max:
		$AudioStreamPlayer3D.stop()

	
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
	$AudioStreamPlayer3D.stop()


func update_visual():
	
	if label:
		if show_degree_in_text:
			label.text = coordText+": "+str(current_degrees) + "°"
		else:
			label.text = coordText+": "+str(current_degrees)
			
	if PerillaMesh:
		var target_rotation = deg_to_rad(-_internal_degrees * 30)
		PerillaMesh.rotation.y = lerp_angle(PerillaMesh.rotation.y,target_rotation,0.15)
