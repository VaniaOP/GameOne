extends CharacterBody3D

#const ROT_SPEED = 0.05
const GRAVITY = -20
const SPEED = 1.3

var state = ''
var anim = ''
var move_speed = 0
var rot_y = 0

var disable_dist_change = false

func _ready():
	Global.player = self
	S('Idle', 'Idle')

func _physics_process(delta):
	#Set velocity to zero
	if is_on_floor():
		velocity = Vector3.ZERO
		if move_speed:
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
		if Input.is_action_just_pressed("space"):
			S('Jump', 'Jump')
			velocity.y = 9
	else:
		velocity.y += GRAVITY*delta
	move_and_slide()

func S(s, a):
	if s && s != state:
		state = s 
	if a && a != anim:
		$AnimationPlayer.play(a, 0.5)

func control(y):
	#Pretty stupid, but it works XD
	if Input.is_action_pressed('ui_up'):
		move_speed = -1
		rot_y = 0
		if Input.is_action_pressed('ui_left'):
			rot_y = PI/4
		elif Input.is_action_pressed('ui_right'):
			rot_y = - PI/4
	elif Input.is_action_pressed('ui_down'):
		move_speed = -1
		rot_y = -PI
		if Input.is_action_pressed('ui_left'):
			rot_y = (3*PI)/4
		elif Input.is_action_pressed('ui_right'):
			rot_y = - (3*PI)/4
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

#TODO better control
