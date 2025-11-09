extends CharacterBody3D

#const ROT_SPEED = 0.05
const GRAVITY = -1
const SPEED = 1.2

func _physics_process(_delta):
	velocity = Vector3()
	if Input.is_action_pressed("ui_left"):
		velocity.x = 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = -1
	if Input.is_action_pressed('ui_up'):
		velocity.z = 1
	elif Input.is_action_pressed('ui_down'):
		velocity.z = -1 
	if velocity:
		$AnimationPlayer.play("Walk")
		velocity = velocity.rotated(Vector3.UP, rotation.y) * SPEED
	else:
		$AnimationPlayer.play("Idle", )
	velocity.y += GRAVITY
	move_and_slide()
