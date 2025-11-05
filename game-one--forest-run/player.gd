extends CharacterBody3D

const ROT_SPEED = 0.05
const GRAVITY = -1
const SPEED = 0.5

func _ready():
	G.player = self

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		G.UpTar(0.75, 1.2, 1.5, 'cam1')
	else:
		G.UpTar(0,2,4,'cam2')
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_left"):
		rotation.y += ROT_SPEED 
	elif Input.is_action_pressed("ui_right"):
		rotation.y -= ROT_SPEED
	if Input.is_action_pressed('ui_up'):
		velocity.z = -1
	elif Input.is_action_pressed('ui_down'):
		velocity.z = 1 
	if velocity.z:
		velocity = velocity.rotated(Vector3.UP, rotation.y) * SPEED
	velocity.y += GRAVITY
	move_and_slide()


#Code taken from messages.
#TODO
#Set up char movement
#Free camera
#Check video I followed last time and copy
