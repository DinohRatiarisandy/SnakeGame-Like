class_name HUD extends CanvasLayer

"""
	This class is responsable for the HUD
"""

@onready var high_score_label: Label = %HighScoreInt
@onready var score_label: Label = %ScoreInt


func _ready() -> void:
	high_score_label.text = str(Global.save_data.high_score)
	score_label.text = "0"


func update_score(score: int) -> void:
	score_label.text = str(score)
