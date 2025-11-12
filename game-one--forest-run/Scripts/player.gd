extends CharacterBody3D

#const ROT_SPEED = 0.05
const GRAVITY = -1
const SPEED = 1.2

var state = ''
var anim = ''
var move_speed = 0
var rot_y = 0

var disable_dist_change = false

func _ready():
	Global.player = self
	S('Idle', 'Idle')

func _physics_process(_delta):
	velocity = Vector3()
	#add jump
	if Input.is_action_just_pressed("space"):
		if is_on_floor():
			S("Jump", "Jump")
			velocity.y += 100
	if move_speed and is_on_floor():
		#add run and crouch
		#may not be the best approach, but it works
		if Input.is_action_pressed("shift"):
			S('Run', 'Run')
			move_speed *= 2.5
		elif Input.is_action_pressed("ctrl"):
			S('Sneak', 'Sneak')
			move_speed *= 2
		else:
			S('Walk', 'Walk')
		velocity.z = move_speed * SPEED
		velocity = velocity.rotated(Vector3.UP, rotation.y)
	else:
		S('Idle', 'Idle')
	velocity.y += GRAVITY
	move_and_slide()

func S(s, a):
	if s && s != state:
		state = s 
	if a && a != anim:
		$AnimationPlayer.play(a, 2)


func control(y):
	if Input.is_action_pressed('ui_up'):
		move_speed = -1
		rot_y = 0
	elif Input.is_action_pressed('ui_down'):
		move_speed = -1
		rot_y = -PI
	elif Input.is_action_pressed('ui_left'):
		move_speed = -1
		rot_y = PI/2
	elif Input.is_action_pressed('ui_right'):
		move_speed = -1
		rot_y = - PI/2
	else:
		move_speed = 0 
	if move_speed:
		transform.basis = Basis(
			transform.basis.get_rotation_quaternion().slerp(
				Basis(Vector3.UP, y + rot_y).get_rotation_quaternion(), 5*get_process_delta_time()
			)
		) 

#TODO: fix jump; see if move code is ok
