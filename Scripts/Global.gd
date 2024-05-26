extends Node

"""
	All global variables.
"""


const GRID_SIZE := 32

var save_data:SaveData


func _ready() -> void:
	save_data = SaveData.load_or_create()
