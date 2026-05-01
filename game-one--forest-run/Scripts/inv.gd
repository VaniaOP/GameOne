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
	
	craft([slot1, slot2])

#works, but can probably be done better
func craft(items:Array):
	#all crafts
	#need more items, these are tests
	var crafts:Dictionary = {['Apple', 'Ginseng']:"res://items/cookie.tres", ['ChiliPowder', 'Stawberry']:"res://items/lamp.tres"}
	var resultSlot = $VBoxContainer/result
	#sort list, so that it is recognised in dict
	items.sort()
	#check if it is in dict
	if items not in crafts:return
	#check if slot free, else move
	if resultSlot.get_child_count() > 0:
		for i in range(resultSlot.get_child_count()):
			var k:int = firstSlot()
			if k != 999:
				resultSlot.get_child(i).reparent(%inv.get_child(k))
			else:
				print('no spot')
				$VBoxContainer/fullMessage.show()
				$VBoxContainer/Button.disabled = true
				await get_tree().create_timer(5.0).timeout
				$VBoxContainer/Button.disabled = false
				$VBoxContainer/fullMessage.hide()
				return
	var n = firstSlot()
	if n == 999: return
	print('all good, crafting')
	#create new child
	var item := InventoryItem.new()
	item.init(load(crafts.get(items)))
	resultSlot.add_child(item)
	#delete old items
	$VBoxContainer/HBoxContainer/Slot1.get_child(0).queue_free()
	$VBoxContainer/HBoxContainer/Slot2.get_child(0).queue_free()
	
func firstSlot():
	var num = %inv.get_child_count()
	for i in num:
		if %inv.get_child(i).get_child_count() == 0:
			if i == (%inv.get_child_count()): return 999
			return i
	return 999
