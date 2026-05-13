extends RayCast3D

@onready var prompt = $Prompt

var current_interactable: Interactable = null
var pointedEnemy: Enemy = null

func _physics_process(_delta):

	prompt.text = ""

	var new_interactable: Interactable = null
	var enemy_found := false

	if is_colliding():

		var collider = get_collider()

		# INTERACTUABLES
		if collider is Interactable:

			new_interactable = collider
			prompt.text = collider.get_prompt()

			if Input.is_action_just_pressed(collider.prompt_action):
				collider.interact(owner)

		var enemy_root = collider.get_parent() as Enemy

		if enemy_root:
			enemy_found = true

			if pointedEnemy and pointedEnemy != enemy_root:
				pointedEnemy.Set_selectedEnemy(false)

			pointedEnemy = enemy_root
			pointedEnemy.Set_selectedEnemy(true)

	if current_interactable and current_interactable != new_interactable:

		if current_interactable.has_method("stop_interacting"):
			current_interactable.stop_interacting()

	current_interactable = new_interactable

	#if not enemy_found and pointedEnemy:
	#	pointedEnemy.Set_selectedEnemy(false)
	#	pointedEnemy = null
	
	#if not enemy_found and pointedEnemy:
		# += _delta
		#if(stop_lookinEnemyTimer>stop_lokkingEnemyTimer_limit):
			#pointedEnemy.Set_selectedEnemy(false)
			#pointedEnemy = null
			#stop_lookinEnemyTimer=0
