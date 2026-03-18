class_name InventorySlot
extends PanelContainer

@export var type: ItemData.Type

var max_stack = 5

func init(t: ItemData.Type, cms:Vector2) -> void:
	type = t
	custom_minimum_size = cms
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			elif type == data.get_parent().type:
				return true
			return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item = get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)
