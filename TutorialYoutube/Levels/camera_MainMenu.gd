extends Camera3D

@export var move_amount: float = 0.08
@export var move_speed: float = 0.4

@export var rotation_amount: float = 0.4
@export var rotation_speed: float = 0.3

var _start_position: Vector3
var _start_rotation: Vector3
var _time: float = 0.0

func _ready() -> void:
	_start_position = global_position
	_start_rotation = rotation_degrees

func _process(delta: float) -> void:
	_time += delta

	var offset_x = sin(_time * move_speed) * move_amount
	var offset_y = cos(_time * move_speed * 0.7) * (move_amount * 0.5)

	global_position = _start_position + Vector3(offset_x, offset_y, 0.0)

	rotation_degrees.x = _start_rotation.x + sin(_time * rotation_speed) * rotation_amount
	rotation_degrees.y = _start_rotation.y + cos(_time * rotation_speed * 0.8) * rotation_amount
