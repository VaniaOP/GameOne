extends Node

var player
var camera
var HP

var DAYTIME

var time

var hud_open:bool


#global damage function
#call GScript.hurt() to deal damage
func hurt(damage=5):
	HP -= damage
