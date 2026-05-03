extends Interactable

var playback : AnimationNodeStateMachinePlayback
var is_open := true

func _ready():
	playback = $"../../../AnimationTree".get("parameters/playback")
	interacted.connect(toggle)
	show_prompt_message()

func toggle(_body):
	is_open = !is_open
	show_prompt_message()
	
	if is_open:
		playback.travel("Closed")
	else:
		playback.travel("Open")

func show_prompt_message():
	if is_open:
		prompt_message = "Open"
	else:
		prompt_message = "Close"
