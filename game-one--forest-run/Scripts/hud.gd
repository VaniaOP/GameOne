extends CanvasLayer

const MAX_HEALTH = 100


func _process(_delta: float) -> void:
	set_health_bar()
	$"weather time".text = "Time: "+str(round(GScript.time))+"s"

func _ready() -> void:
	set_health_bar()
	$HealthBar.max_value = MAX_HEALTH
	
func set_health_bar() -> void:
	$HealthBar.value = GScript.HP
	if GScript.HP >= 50: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(0, 137, 30)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
	if GScript.HP < 50 and GScript.HP >= 25: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(242, 139, 78)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
	if GScript.HP < 25: 
		var new_style = $HealthBar.get_theme_stylebox("fill")
		new_style.bg_color = Color8(213, 0, 26)
		$HealthBar.add_theme_stylebox_override("fill", new_style)
