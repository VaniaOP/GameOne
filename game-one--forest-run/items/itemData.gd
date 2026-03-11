extends Resource
class_name ItemData

enum Type {TOOL, FOOD, HERB, MAIN}

@export var type: Type
@export var item_name: String
@export_multiline var description: String
@export var texture: Texture2D
