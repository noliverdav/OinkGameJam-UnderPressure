extends Node

@export var light_node: Light3D

@export var min_energy: float = 0.15
@export var max_energy_variation: float = 0.25

@export var min_interval: float = 0.2
@export var max_interval: float = 1.2

@export var smooth_speed: float = 2.0

var _base_energy: float
var _target_energy: float
var _timer: float = 0.0

func _ready() -> void:
	if light_node == null:
		push_error("LightFlicker: assign a light.")
		return

	_base_energy = light_node.light_energy
	_target_energy = _base_energy

func _process(delta: float) -> void:
	if light_node == null:
		return

	_timer -= delta

	if _timer <= 0.0:
		_timer = randf_range(min_interval, max_interval)

		if randf() < 0.25:
			_target_energy = randf_range(min_energy, _base_energy * 0.4)
		else:
			_target_energy = randf_range(
				_base_energy - max_energy_variation,
				_base_energy
			)

	light_node.light_energy = lerp(
		light_node.light_energy,
		_target_energy,
		delta * smooth_speed
	)
