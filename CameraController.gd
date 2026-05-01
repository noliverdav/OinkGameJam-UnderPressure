class_name CameraController extends Node3D
@export_category("References")
@export var component_mouse_capture : MouseCaptureComponent #Esto seria como declarar una variable para asignar en el inspector

@export_range(-90, -60) var tilt_lower_limit : int = -90
@export_range(60, 90) var tilt_upper_limit : int = 90
@export_group("Crouch Vertical Movement")
@export var crouch_offset : float = 0.0
@export var crouch_speed : float = 3.0

var _rotation : Vector3
const DEFAULT_HEIGHT : float = 0.5



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_camera_rotation(component_mouse_capture._mouse_input)

func update_camera_rotation(input: Vector2) -> void:
	_rotation.x += input.y
	_rotation.y += input.x

	# Clamp del pitch (vertical)
	_rotation.x = clamp(
		_rotation.x,
		deg_to_rad(tilt_lower_limit),
		deg_to_rad(tilt_upper_limit)
	)

	# 🎯 ROTACIÓN VERTICAL (cámara)
	rotation.x = _rotation.x

	# 🎯 ROTACIÓN HORIZONTAL (player)
	get_parent().rotation.y = _rotation.y

	# Evitar inclinación lateral
	rotation.z = 0.0
	
func update_camera_height(delta: float, direction: int) -> void:
	if position.y >= crouch_offset and position.y <= DEFAULT_HEIGHT:
		position.y = clampf(position.y + (crouch_speed * direction) * delta, crouch_offset, DEFAULT_HEIGHT)
