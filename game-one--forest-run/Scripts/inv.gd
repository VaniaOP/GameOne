extends CanvasLayer

var InvSize = 36

var itemsLoad = [
	"res://items/apple.tres",
	"res://items/ginseng.tres",
	"res://items/chiliPowder.tres",
	"res://items/cookie.tres",
	"res://items/strawberry.tres",
	"res://items/apple.tres"
]

func _ready() -> void:
	self.visible = false
	GScript.hud_open = false
	for i in InvSize:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(72,72))
		%inv.add_child(slot)
	for i in itemsLoad.size():
		var item := InventoryItem.new()
		item.init(load(itemsLoad[i]))
		%inv.get_child(i).add_child(item)
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('inv'):
		self.visible = !self.visible
		if self.visible == true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			GScript.hud_open = true
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			GScript.hud_open = false
