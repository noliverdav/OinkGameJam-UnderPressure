extends Node3D
class_name Escotilla
var is_open := true
var playback : AnimationNodeStateMachinePlayback


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playback = $AnimationTree.get("parameters/playback")
	if is_open:
		playback.travel("Open")
	else:
		playback.travel("Closed")

func toggle():
	is_open = !is_open
	var state = "Open" if is_open else "Closed"
	playback.travel(state)
