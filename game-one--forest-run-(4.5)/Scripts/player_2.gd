extends Node3D

var speed = 0
const GRAVITY = -1

func _process(delta: float) -> void:
	if speed:
		translate(Vector3(0,0,-2*delta))

func control(cam_y):
	speed = 1 if Input.is_action_pressed('ui_up') else 0
	rotation.y = cam_y
