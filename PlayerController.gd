class_name PlayerController
extends CharacterBody3D

#region Movement
@export var speed : float = 5.0
@export var acceleration : float = 10.0
@export var gravity : float = 9.8

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	input_dir = input_dir.normalized()
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction != Vector3.ZERO:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
		velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0
	
	move_and_slide()
#endregion

#region Interacion
@onready var raycast : RayCast3D = $CameraController/Camera3D/RayCast3D

var is_interacting := false

func _process(delta):
	if raycast.is_colliding():
		var obj = raycast.get_collider()
	
		while obj != null:
			if obj is Interactable:
				print("interactable")
				break
			obj = obj.get_parent()

	if Input.is_action_just_pressed("interact") and not is_interacting:
		try_interact()

func try_interact():
	if not raycast.is_colliding():
		return
	
	var collider = raycast.get_collider()
	var obj = collider
	
	while obj != null:
		if obj is Interactable:
			start_interaction(obj)
			return
		obj = obj.get_parent()

func start_interaction(obj: Interactable):
	is_interacting = true
	
	if obj.interaction_time > 0:
		await get_tree().create_timer(obj.interaction_time).timeout
	
	obj.interact(self)
	is_interacting = false
#endregion
