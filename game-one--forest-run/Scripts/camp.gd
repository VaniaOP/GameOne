extends Node3D

func _ready() -> void:
	$CanvasLayer.hide()

func _physics_process(_delta: float) -> void:
	var bodies = $Area3D.get_overlapping_bodies()
	print(bodies)
	for body in bodies:
		if body is not playerClass: continue
		print('player in')
		if Input.is_action_just_released("interact"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$CanvasLayer.show()


func _on_button_pressed() -> void:
	pass # rest
	


func _on_no_pressed() -> void:
	$CanvasLayer.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	return
