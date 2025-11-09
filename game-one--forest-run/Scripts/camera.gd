extends Marker3D

@export_node_path() var target_node :NodePath
var camera
var target
var rot_y = 0

func _ready():
	target = get_node(target_node)
	camera = $Camera3D
	
func _process(delta: float) -> void:
	transform.origin = target.transform.origin + Vector3(0, 1.5, 0)
	if Input.is_action_pressed('ui_up'):
		target.move_speed = -1
		rot_y = rotation.y
	elif Input.is_action_pressed('ui_down'):
		target.move_speed = -1
		rot_y = rotation.y - PI
	elif Input.is_action_pressed('ui_left'):
		target.move_speed = -1
		rot_y = rotation.y + PI/2
	elif Input.is_action_pressed('ui_right'):
		target.move_speed = -1
		rot_y = rotation.y - PI/2
	else:
		target.move_speed = 0 
	
	if target.move_speed:
		target.transform.basis = Basis(target.transform.basis.get_rotation_quaternion().slerp(Basis(Vector3.UP, rot_y).get_rotation_quaternion(), 5*delta)) 
	
	if $detector.is_colliding():
		camera.transform.origin.z = $detector.get_collision_point().distance_to(global_transform.origin) - 0.5
	else:
		camera.transform.origin.z = 5
func _input(e):
	if e is InputEventMouseMotion:
		rotation.y -= e.relative.x * 0.01
		rotation.x = clamp(rotation.x - e.relative.y * 0.01, -1, 0.2)
