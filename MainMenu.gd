extends Node3D

@onready var play_button = $CanvasLayer/VBoxContainer/Play
@onready var exit_button = $CanvasLayer/VBoxContainer/Exit

func _ready():
	play_button.pressed.connect(_on_play)
	exit_button.pressed.connect(_on_exit)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play():
	get_tree().change_scene_to_file("res://TutorialYoutube/Levels/TestRoom.tscn")

func _on_exit():
	get_tree().quit()
