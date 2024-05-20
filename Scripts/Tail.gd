class_name Tail extends SnakePart

@export var textures: Array[Texture]
@onready var tail_sprite: Sprite2D = $TailSprite


func _ready() -> void:
	tail_sprite.texture = textures.pick_random()
