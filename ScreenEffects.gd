extends ColorRect

@export var flash_color: Color = Color(1.0, 0.25, 0.0, 0.55)
@export var flash_duration: float = 0.1
@export var vignette_duration: float = 1.0

func _ready() -> void:
	color = Color(0, 0, 0, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	GameState.value_changed.connect(_on_value_changed)

func _on_value_changed(key: String, value) -> void:
	if key == "health":
		flash_damage()

func flash_damage() -> void:
	var tween = create_tween()
	tween.tween_property(self, "color", flash_color, flash_duration * 0.25)
	tween.tween_property(self, "color", Color(0, 0, 0, 0), flash_duration)

	await get_tree().create_timer(flash_duration).timeout
	var tween2 = create_tween()
	tween2.tween_property(self, "color", Color(0, 0, 0, 0.4), 0.08)
	tween2.tween_property(self, "color", Color(0, 0, 0, 0.0), vignette_duration)
