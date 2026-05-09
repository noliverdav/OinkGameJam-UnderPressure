extends Node

@export var light_node: Light3D
@export var flicker_duration: float = 2.0
@export var flicker_speed: float = 0.05
@export var min_energy: float = 0.0

var _base_energy: float
var _timer: float = 0.0
var _flicker_timer: float = 0.0
var _flickering: bool = false

func _ready() -> void:
	if light_node == null:
		push_error("LightFlicker: asigná la luz en el inspector.")
		return
	_base_energy = light_node.light_energy
	GameState.value_changed.connect(_on_value_changed)

func _on_value_changed(key: String, value) -> void:
	if key == "health":
		_timer = flicker_duration
		_flickering = true

func _process(delta: float) -> void:
	if not _flickering or light_node == null:
		return

	_timer -= delta
	_flicker_timer -= delta

	if _flicker_timer <= 0.0:
		_flicker_timer = flicker_speed * randf_range(0.5, 2.5)
		if randf() < 0.4:
			light_node.light_energy = randf_range(min_energy, min_energy + 0.15)
		else:
			light_node.light_energy = randf_range(_base_energy * 0.3, _base_energy)

	if _timer <= 0.0:
		_flickering = false
		var tween = create_tween()
		tween.tween_property(light_node, "light_energy", _base_energy, 0.5).set_ease(Tween.EASE_OUT)
