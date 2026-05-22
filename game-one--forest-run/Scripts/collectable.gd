extends Node3D

@export var resource:ItemData

func _ready():
	$Sprite3D.texture = resource.texture
	$AnimationPlayer.play("idle")
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not playerClass: return
	var res = GScript.inventoryAddItem(resource)
	if res == 0: return
	self.queue_free()
