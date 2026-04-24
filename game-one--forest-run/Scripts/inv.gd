extends CanvasLayer

var InvSize = 36

var itemsLoad = GScript.inventoryItems

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


func _on_button_pressed() -> void:
	if $VBoxContainer/HBoxContainer/Slot1.get_child_count() == 0: return
	if $VBoxContainer/HBoxContainer/Slot2.get_child_count() == 0: return
	var slot1 = $VBoxContainer/HBoxContainer/Slot1.get_child(0).data.itemName
	var slot2 = $VBoxContainer/HBoxContainer/Slot2.get_child(0).data.itemName
	
	print(slot1)
	
	craft([slot1, slot2])

func craft(items:Array):
	#all crafts
	var crafts:Dictionary = {['Apple', 'Ginseng']:"res://items/cookie.tres"}
	var resultSlot = $VBoxContainer/result
	#sort list, so that it is recognised in dict
	items.sort()
	#check if it is in dict
	if items not in crafts:return
	if resultSlot.get_child_count() > 1: return
	#create new child
	var item := InventoryItem.new()
	item.init(load(crafts.get(items)))
	resultSlot.add_child(item)
	#delete old items
	
