extends Node

@export var base_amount: int = 10
@export var burst_amount: int = 80
@export var burst_duration: float = 3.0

var _particles: GPUParticles3D
var _timer: float = 0.0
var _bursting: bool = false

func _ready() -> void:
	_particles = get_parent() as GPUParticles3D
	_particles.amount = base_amount
	_particles.emitting = true
	GameState.value_changed.connect(_on_value_changed)

func _on_value_changed(key: String, value) -> void:
	if key == "health":
		_timer = burst_duration
		_bursting = true
		_particles.amount = burst_amount

		var pm = _particles.process_material as ParticleProcessMaterial
		if pm:
			pm.initial_velocity_min = 1.5
			pm.initial_velocity_max = 4.0
			pm.spread = 35.0

func _process(delta: float) -> void:
	if not _bursting:
		return

	_timer -= delta
	if _timer <= 0.0:
		_bursting = false
		var tween = create_tween()
		tween.tween_method(_set_amount.bind(), float(burst_amount), float(base_amount), 2.0)

		var pm = _particles.process_material as ParticleProcessMaterial
		if pm:
			pm.initial_velocity_min = 0.2
			pm.initial_velocity_max = 0.8
			pm.spread = 10.0

func _set_amount(value: float) -> void:
	_particles.amount = int(value)
