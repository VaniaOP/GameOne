extends Node

var player
var camera

var DAYTIME

var time

var hud_open:bool

var playerStat:Dictionary = {'Health':100, 'MaxHealth':100, 'Agility':50, 'Weight':70}

func attribute(changes:Dictionary):
	if changes.Health != 0:
		playerStat.Health *= changes.Health
		clamp(playerStat.Health, 0, playerStat.MaxHealth)
	if changes.MaxHealth != 0:
		playerStat.MaxHealth *= changes.MaxHealth
	if changes.Agility != 0:
		playerStat.Agility *= changes.Agility
	if changes.Weight != 0:
		playerStat.Weight *= changes.Weight
	
