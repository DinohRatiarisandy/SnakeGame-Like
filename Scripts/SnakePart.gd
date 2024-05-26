class_name SnakePart extends Area2D

"""
	This class is the base class of all snake portions, ex: Head, snake body, ...
"""

var last_position: Vector2


func move_to(new_position: Vector2) -> void:
	last_position = self.position
	self.position = new_position
