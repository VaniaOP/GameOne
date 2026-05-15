extends Node3D

var timerTime:int

@export var marker:Node
@export var timerNode:Node

var minTime:int = 20
var maxTime:int = 300

const collectable:String = "res://models/scenes/collectable.tscn"

#func _process(delta: float) -> void:

func _ready() -> void:
	timerTime = randi_range(minTime, maxTime)
	timerNode.wait_time = timerTime
	timerNode.start()
	
func timer():
	if marker.get_child_count() > 0: return
	var scene = preload(collectable).instantiate()
	var res = GScript.resources.pick_random()
	scene.resource = load(res)
	marker.add_child(scene)
	timerTime = randi_range(minTime, maxTime)
	timerNode.wait_time = timerTime
	
