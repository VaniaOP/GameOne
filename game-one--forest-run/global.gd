extends Node

var player
var camera

var DAYTIME

var time

var hud_open:bool

var playerStat:Dictionary = {'health':100, 'maxHealth':100, 'agility':50, 'weight':70}

signal update

#global function to change player attributes
#time set to 999 = permanent upgrade
func attribute(changes:Dictionary, time:int=999):
	var old:Dictionary = playerStat
	update.emit()
	if changes.health != 0:
		playerStat.health *= changes.health
		clamp(playerStat.Health, 0, playerStat.maxHealth)
	if changes.maxHealth != 0:
		playerStat.maxHealth *= changes.maxHealth
	if changes.agility != 0:
		playerStat.agility *= changes.agility
	if changes.weight != 0:
		playerStat.weight *= changes.weight
	if time != 999:
		var t = Timer.new()
		t.wait_time = time
		t.start()
		await t.timeout
		playerStat = old
		update.emit()
	return
	
	
#function to check singal
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("hud"):
		#playerStat.maxHealth += 2
		#update.emit()
	
	
