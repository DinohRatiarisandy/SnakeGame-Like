class_name Tail extends SnakePart

"""
	This class is the snake tail (or snake body).
	It create new sprite randomly when snake eat food.
"""

@export var textures: Array[Texture]
@onready var tail_sprite: Sprite2D = $TailSprite


func _ready() -> void:
	tail_sprite.texture = textures.pick_random()
