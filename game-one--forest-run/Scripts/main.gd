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
	#actual time
	$weather_timer.wait_time = randi_range(120, 300)
	#testing time
	#$weather_timer.wait_time = randi_range(3, 6)
	$weather_timer.start()
		
func _process(_delta: float) -> void:
	SimpleGrass.set_player_position($Player.position)
	if Input.is_action_just_released("quit"):
		get_tree().quit()
	GScript.DAYTIME = daytime
	#used to check weather switch
	if Input.is_action_just_released("change_weather"):
		change_clouds()
	GScript.time = $weather_timer.time_left
	
func _on_secret_scene_body_entered(_body: Node3D) -> void:
	if daytime != "night": return
	# secret forest scene
	pass

func change_clouds(select:String=""):
	#need to make it gradual
	var env:Environment
	env = $WorldEnvironment.environment
	var weather:String
	var weather_list = ['normal', 'cloudy', 'rainy', 'thunderstorm', 'clear']
	if not select:
		weather = weather_list.pick_random()
	else:
		if not select in weather_list: return
		weather = select
	$Player/GPUParticles3D.emitting = false
	env.volumetric_fog_density = 0.0015
	match weather:
		'normal':
			c_cov = 0.286
			c_smo = 0.045
		'cloudy':
			c_cov = 0.469
			c_smo = 0.095
		'rainy':
			env.volumetric_fog_density = 0.02
			c_cov = 0.586
			c_smo = 0.041
			$Player/GPUParticles3D.emitting = true
		'thunderstorm':
			env.volumetric_fog_density = 0.02
			c_cov = 0.586
			c_smo = 0.041
			$Player/GPUParticles3D.emitting = true
		'clear':
			c_cov = 0.188
			c_smo = 0.035
	clouds.set_shader_parameter("coverage", c_cov)
	clouds.set_shader_parameter("cloud_smoothness", c_smo)


func _on_weather_timer_timeout() -> void:
	change_clouds()
	#actual time
	$weather_timer.wait_time = randi_range(120, 300)
	#testing time
	#$weather_timer.wait_time = randi_range(3, 6)
	$weather_timer.start()
