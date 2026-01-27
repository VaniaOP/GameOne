extends Node

var player
var camera
var HP


#global damage function
#call GScript.hurt() to deal damage
func hurt(damage=5):
	HP -= damage
