extends RayCast3D

@onready var prompt = $Prompt
var current_interactable: Interactable = null
var pointedEnemy:Enemy = null;

var stop_lookinEnemyTimer := 0.0
var stop_lokkingEnemyTimer_limit:=5.0;


func _physics_process(_delta):
	prompt.text = ""
	var enemy_found := false

	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.get_prompt()
			current_interactable = collider

			if Input.is_action_just_pressed(collider.prompt_action):
				collider.interact(owner)
			return

		var enemy_root = collider.get_parent() as Enemy
		if enemy_root:
			enemy_found = true

			if pointedEnemy and pointedEnemy != enemy_root:
				pointedEnemy.Set_selectedEnemy(false)
				
			pointedEnemy = enemy_root
			pointedEnemy.Set_selectedEnemy(true)

	if current_interactable:
		if current_interactable.has_method("stop_interacting"):
			current_interactable.stop_interacting()

	current_interactable = null
	
	if not enemy_found and pointedEnemy:
		stop_lookinEnemyTimer += _delta
		if(stop_lookinEnemyTimer>stop_lokkingEnemyTimer_limit):
			pointedEnemy.Set_selectedEnemy(false)
			pointedEnemy = null
			stop_lookinEnemyTimer=0
