extends CharacterBody3D

#const ROT_SPEED = 0.05
const GRAVITY = -1
const SPEED = 1.2

var state = ''
var anim = ''
var move_speed = 0

func _ready():
	S('Idle', 'Idle')

func _physics_process(_delta):
	velocity = Vector3()
	if move_speed:
		velocity.z = move_speed * SPEED
		#var r
		#if move_speed > 0:
			#r=true
		#else:
			#r=false
		#Used before adding quaternions
		#Need to add r to S(), and modify function
		S('Walk', 'Walk')
		velocity = velocity.rotated(Vector3.UP, rotation.y)
	else:
		S('Idle', 'Idle')
	velocity.y += GRAVITY
	move_and_slide()

func S(s, a, r=false):
	if s && s != state:
		state = s 
	if a && a != anim:
		#var anim_speed
		#if not r:
			#anim_speed = 1
		#else:
			#anim_speed = -1
		#Used before adding queternions
		#add anim_speed to play() if need to use again
		$AnimationPlayer.play(a, 2)
