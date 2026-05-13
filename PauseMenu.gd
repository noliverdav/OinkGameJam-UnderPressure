extends CanvasLayer

@onready var reanudar_button = $Panel/VBoxContainer/Reanudar
@onready var salir_button = $Panel/VBoxContainer/Salir
@onready var volume_slider = $Panel/VBoxContainer/HBoxContainer/VolumeSlider

func _ready():
	reanudar_button.pressed.connect(_on_reanudar)
	salir_button.pressed.connect(_on_salir)
	volume_slider.value_changed.connect(_on_volume_changed)
	
	# Configurar el slider
	volume_slider.min_value = 0.0
	volume_slider.max_value = 1.0
	volume_slider.step = 0.01
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_volume_changed(value: float):
	# Convierte 0.0-1.0 a decibeles y aplica al bus Master
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_reanudar():
	toggle_pause()

func _on_salir():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://TutorialYoutube/Levels/MainMenu.tscn")
