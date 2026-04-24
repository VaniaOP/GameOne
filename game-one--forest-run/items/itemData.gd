extends Resource
class_name ItemData

enum Type {TOOL, FOOD, HERB, MAIN, CRAFT, RESULT}


@export var type: Type
@export var itemName: String
@export_multiline var description: String
@export var texture: Texture2D
@export var consumable:bool
@export_category("Stat Buffs")
@export_group("Buffs")
@export var MaxHealthBoost: int
@export var AgilityBoost:int
@export var WeightBoost:int
@export_group("Craft Buffs")
@export var MaxHealthBoostCraft: int
@export var AgilityBoostCraft:int
@export var WeightBoostCraft:int
