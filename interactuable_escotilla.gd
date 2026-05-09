extends Interactable


func _ready():
	interacted.connect(toggle)
	show_prompt_message()

func toggle(_body):
	owner.toggle() # Just tell the owner to do its thing
	show_prompt_message()

func show_prompt_message():
	prompt_message = "Close" if owner.is_open else "Open"
