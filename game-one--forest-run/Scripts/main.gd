extends Node3D
@export var daytime:String = "day"

var clouds = preload("res://materials/SkyMaterial.tres")

var c_cov:float
var c_smo:float

var m_x:float
var m_y:float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SimpleGrass.set_interactive(true)
	$Daynight.play("cycler")
	c_cov = randi_range(0, 1)
	c_smo = randi_range(0, 1)

func _process(delta: float) -> void:
	if Input.is_action_just_released("quit"):
		get_tree().quit()
	GScript.DAYTIME = daytime

	c_cov += delta * 10
	c_smo += delta *10
	clouds.set_shader_parameter("shader_parameter/coverage", c_cov)
	clouds.set_shader_parameter("shader_parameter/cloud_smoothness", c_smo)



func _on_secret_scene_body_entered(body: Node3D) -> void:
	if daytime != "night": return
	# secret forest scene


func _on_daynight_animation_changed(old_name: StringName, new_name: StringName) -> void:
	c_cov = randi_range(0, 1)
	c_smo = randi_range(0, 1)
	$Moon.rotation = Vector3(m_x, m_y, 0)
