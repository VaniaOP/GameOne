extends Node

var player
var camera

var DAYTIME

var hud_open:bool

var inv

var playerStat:Dictionary = {'health':100.0, 'maxHealth':100.0, 'agility':50.0, 'weight':70.0}

signal update

var inventoryItems:Array = [
	"res://items/apple.tres",
	"res://items/ginseng.tres",
	"res://items/cookie.tres",
	"res://items/strawberry.tres",
	"res://items/apple.tres"
	]
	
var resources = [
	"res://items/apple.tres",
	"res://items/ginseng.tres",
	"res://items/strawberry.tres",
	]

#global function to change player attributes
#time set to 999 = permanent upgrade
func attribute(changes:Dictionary, timerTime:int=999):
	var save = playerStat.duplicate()
	print(playerStat)
	update.emit()
	if changes.has("maxHealth"):
		playerStat.maxHealth = playerStat.maxHealth + playerStat.maxHealth*(changes.maxHealth/100)
	if changes.has("health"):
		playerStat.health = playerStat.health + playerStat.health*(changes.health/100)
		clamp(playerStat.Health, 0, playerStat.maxHealth)
	if changes.has("agility"):
		playerStat.agility = playerStat.agility + playerStat.agility*(changes.agility/100)
	if changes.has("weight"):
		playerStat.weight = playerStat.weight + playerStat.weight*(changes.weight/100)
	print(playerStat)
	if timerTime != 999:
		await get_tree().create_timer(timerTime).timeout
		playerStat = save
		print(playerStat)
		update.emit()
	return

#function to check singal
#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("hud"):
		##create a dictionary to pass to the function
		##keys have to correspond to keys in playerStat dict
		##values are percentages
		##values have to be floats
		#var attributes:Dictionary = {'maxHealth':20.0, 'agility':20.0}
		##dont set time if you want upgrades permanent
		#attribute(attributes, 2)

#this process function somehow slows down the scene
#maybe search for a better way for applying attributes


#add item to inventory, if full return 999
func inventoryAddItem(item:ItemData) -> int:
	var slot = inv.firstSlot()
	if slot == 999: return 0
	var obj = item.resource_path
	inventoryItems.append(obj)
	inv.newItem(slot)
	return 1
