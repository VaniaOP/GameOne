extends Marker3D

@export_node_path() var target_node :NodePath
@export var max_distance:float=5.0:
	set(value):
		max_distance = clamp(value, MIN_DIST, MAX_DIST)
@export var offset = Vector3(0, 1.5, 0)

const MAX_DIST = 7
const MIN_DIST = 1

var camera
var target
var rot_y = 0

var is_control = false 

var disable_dist_change = false

func _ready():
	GScript.camera = self
	target = get_node(target_node)
	camera = $Camera3D
	is_control = target.has_method('control')
	disable_dist_change = 'disable_dist_change' in target && target.disable_dist_change
	upd_detector()
	
func _process(_delta: float) -> void:
	transform.origin = target.transform.origin + offset
	if is_control and !GScript.hud_open:
		target.control(rotation.y)
	if $detector.is_colliding():
		camera.transform.origin.z = $detector.get_collision_point().distance_to(global_transform.origin) - 0.5
	else:
		camera.transform.origin.z = max_distance

func upd_detector():
	$detector.target_position.z = max_distance
func _input(e):
	if !GScript.hud_open:
		if e is InputEventMouseMotion:
			rotation.y -= e.relative.x * 0.01
			rotation.x = clamp(rotation.x - e.relative.y * 0.01, -0.7, 0.5)
		if e is InputEventMouseButton:
			if not disable_dist_change:
				if e.button_index == 5:
					max_distance += 0.5
					upd_detector()
				elif e.button_index == 4:
					max_distance -= 0.5
					upd_detector()
