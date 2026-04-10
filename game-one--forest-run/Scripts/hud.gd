extends CanvasLayer

var fps

func updateMaxHealth():
	#print(GScript.playerStat.maxHealth)
	$HealthBar.max_value = GScript.playerStat.maxHealth
	$health.text = "Max health: " + str(GScript.playerStat.maxHealth)
	set_health_bar()

func _process(delta: float) -> void:
	set_health_bar()
	$"weather time".text = "Time: "+str(round(GScript.time))+"s"
	fps = round(1/delta)
	$fps.text = "FPS: "+str(fps)
	if Input.is_action_just_pressed('hud'):
		self.visible = true
		await get_tree().create_timer(5.0).timeout
		self.visible = false

func _ready() -> void:
	GScript.update.connect(updateMaxHealth)
	set_health_bar()
	$HealthBar.max_value = GScript.playerStat.maxHealth
	$health.text = "Max health: " + str(GScript.playerStat.maxHealth)
	self.visible = false
	
	
func set_health_bar() -> void:
	$HealthBar.value = GScript.playerStat.health
	if GScript.playerStat.health >= $HealthBar.max_value/2: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(0, 137, 30)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
	if GScript.playerStat.health < $HealthBar.max_value/2 and GScript.playerStat.health >= $HealthBar.max_value/4: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(242, 139, 78)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
	if GScript.playerStat.health < $HealthBar.max_value/4: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(213, 0, 26)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
