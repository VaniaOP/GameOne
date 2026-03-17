extends TextureRect
class_name InventoryItem

@export var data: ItemData

func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	tooltip_text = "%s\n%s" % [data.item_name, data.description]

func init(d:ItemData) -> void:
	data = d
