extends Node3D
@export var daytime:String = "day"

@export var clouds: ShaderMaterial = preload("res://materials/SkyMaterial.tres")

var c_cov:float
var c_smo:float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SimpleGrass.set_interactive(true)
	daytime="day"
	change_clouds("normal")
	$Daynight.play("cycler")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_released("quit"):
		get_tree().quit()
	GScript.DAYTIME = daytime

	if daytime == 'night':
		change_clouds()
	



func _on_secret_scene_body_entered(_body: Node3D) -> void:
	if daytime != "night": return
	# secret forest scene
	pass

func change_clouds(select:String=""):
	var weather:String
	var weather_list = ['normal', 'cloudy', 'rainy', 'thunderstorm', 'clear']
	if not select:
		weather = weather_list.pick_random()
		print(weather)
	else:
		if not select in weather_list: return
		weather = select
		print(select)
	
	match weather:
		'normal':
			c_cov = 0.286
			c_smo = 0.045
		'cloudy':
			c_cov = 0.469
			c_smo = 0.095
		'rainy':
			c_cov = 0.586
			c_smo = 0.041
		'thunderstorm':
			c_cov = 0.586
			c_smo = 0.041
		'clear':
			c_cov = 0.188
			c_smo = 0.035
	clouds.set_shader_parameter("coverage", c_cov)
	clouds.set_shader_parameter("cloud_smoothness", c_smo)
