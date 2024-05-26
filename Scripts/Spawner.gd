class_name Spawner extends Node2D

"""
	This class is responsable to spawn new food, and tail (grow snake).
"""

signal tail_added(tail: Tail)

@export var bounds: Bounds

@onready var food_to_eat: Node = %FoodToEat
@onready var snake_parts: Node = %SnakeParts

var food_scene: PackedScene = preload("res://Scenes/food.tscn")
var tail_scene: PackedScene = preload("res://Scenes/tail.tscn")


func spanw_food() -> void:
	var spanw_point: Vector2 = Vector2.ZERO
	spanw_point.x = randf_range(bounds.x_min + Global.GRID_SIZE, bounds.x_max - Global.GRID_SIZE)
	spanw_point.y = randf_range(bounds.y_min + Global.GRID_SIZE, bounds.y_max - Global.GRID_SIZE)
	spanw_point.x = floorf(spanw_point.x / Global.GRID_SIZE) * Global.GRID_SIZE
	spanw_point.y = floorf(spanw_point.y / Global.GRID_SIZE) * Global.GRID_SIZE
	var food := food_scene.instantiate()
	# HACK: Not spawn the food in one position of all snake body, or wall position (feature).
	food.position = spanw_point
	food_to_eat.add_child(food)


func spanw_tail(pos: Vector2) -> void:
	"""
		Add a new body in the last position of the snake (new tail).
		The snake grow.
	"""
	var tail: Tail = tail_scene.instantiate() as Tail
	tail.position = pos
	snake_parts.add_child(tail)
	tail_added.emit(tail)
