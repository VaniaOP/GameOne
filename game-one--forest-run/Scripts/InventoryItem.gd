extends TextureRect
class_name InventoryItem

@export var data: ItemData

func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tooltip_text = "%s\n%s" % [data.item_name, data.description]

func init(d:ItemData) -> void:
	data = d
	
func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2):
	var t := TextureRect.new()
	t.texture = texture
	t.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size * 1.25
	t.modulate.a = 0.9
	t.position = Vector2(-at_position)
	
	var c := Control.new()
	c.add_child(t)
	return c
