extends Node3D
@export var daytime:String = "day"

@export var clouds: ShaderMaterial = preload("res://materials/SkyMaterial.tres")
@onready var sun: DirectionalLight3D = $Sun

var c_cov:float
var c_smo:float

var blur:float


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
		
var quitFrames = 0
		
func _process(delta: float) -> void:
	#if GScript.hud_open:
	SimpleGrass.set_player_position($Player.position)
	if Input.is_action_pressed("quit"):
		quitFrames += delta
		if quitFrames >= 1:
			get_tree().quit()
	if Input.is_action_just_released("quit"):
		quitFrames = 0
	GScript.DAYTIME = daytime
	#used to check weather switch
	if Input.is_action_just_released("change_weather"):
		change_clouds()
	
	
func _on_secret_scene_body_entered(_body: Node3D) -> void:
	if daytime != "night": return
	# secret forest scene
	pass

func change_clouds(select:String=""):
	#need to make it gradual
	var env:Environment
	env = $WorldEnvironment.environment
	var weather:String
	var weather_list = ['normal', 'cloudy', 'rainy', 'thunderstorm', 'clear', 'snow']
	if not select:
		weather = weather_list.pick_random()
	else:
		if not select in weather_list: return
		weather = select
	$Player/rain.emitting = false
	$Player/snow.emitting = false
	env.volumetric_fog_density = 0.0015
	match weather:
		'normal':
			c_cov = 0.286
			c_smo = 0.045
			blur = 1.0
		'cloudy':
			c_cov = 0.469
			c_smo = 0.095
			blur = 1.4
		'rainy':
			env.volumetric_fog_density = 0.02
			c_cov = 0.586
			c_smo = 0.041
			blur = 1.4
			$Player/rain.emitting = true
		'thunderstorm':
			env.volumetric_fog_density = 0.02
			c_cov = 0.586
			c_smo = 0.041
			blur = 1.4
			$Player/rain.emitting = true
		'clear':
			c_cov = 0.188
			c_smo = 0.035
			blur = 1.0
		'snow':
			env.volumetric_fog_density = 0.02
			c_cov = 0.586
			c_smo = 0.041
			blur = 1.4
			$Player/snow.emitting = true
	clouds.set_shader_parameter("coverage", c_cov)
	clouds.set_shader_parameter("cloud_smoothness", c_smo)
	sun.shadow_blur = blur
	


func _on_weather_timer_timeout() -> void:
	change_clouds()
	#actual time
	$weather_timer.wait_time = randi_range(120, 300)
	#testing time
	#$weather_timer.wait_time = randi_range(3, 6)
	$weather_timer.start()
