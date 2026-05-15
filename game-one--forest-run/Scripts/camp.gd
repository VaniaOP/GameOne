extends Node3D

func _physics_process(delta: float) -> void:
	var bodies = $Area3D.get_overlapping_bodies()
	for i in bodies:
		if i is not PLAYER: return
		#if Input.is_action_just_pressed("interact")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not PLAYER: return
	
