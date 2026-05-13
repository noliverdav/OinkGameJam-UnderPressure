extends Node

@export var camera: Camera3D
@export var max_offset: float = 0.15
@export var max_rotation: float = 0.015
@export var decay: float = 4.5

var _trauma: float = 0.0
var _origin_position: Vector3
var _origin_rotation: Vector3

func _ready() -> void:
	if camera == null:
		push_error("CameraShaker: asignar la Camera3D en el inspector.")
		return
	_origin_position = camera.position
	_origin_rotation = camera.rotation
	GameState.value_changed.connect(_on_value_changed)

func _on_value_changed(key: String, value) -> void:
	if key == "health":
		shake(0.8)

func shake(intensity: float) -> void:
	_trauma = clamp(_trauma + intensity, 0.0, 1.0)

func _process(delta: float) -> void:
	if camera == null or _trauma <= 0.0:
		return

	var p = _trauma * _trauma
	camera.position = _origin_position + Vector3(
		max_offset * p * randf_range(-1.0, 1.0),
		max_offset * p * randf_range(-1.0, 1.0),
		0.0
	)
	camera.rotation.z = _origin_rotation.z + max_rotation * p * randf_range(-1.0, 1.0)

	_trauma = max(0.0, _trauma - decay * delta)
	if _trauma <= 0.01:
		_trauma = 0.0
		camera.position = _origin_position
		camera.rotation = _origin_rotation
