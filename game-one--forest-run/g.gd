extends Node

var player
var offset
var key = 'camera'

func UpTar(Tx, Ty, Tz, K):
	if K != key:
		offset = Vector3(Tx, Ty, Tz)
		key = K
	
