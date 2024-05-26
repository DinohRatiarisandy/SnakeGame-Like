class_name StartScreen extends CanvasLayer

"""
	This class is responsable of the MainMenu screen.
"""

const GAMEPLAY_SCN: PackedScene = preload("res://Scenes/gameplay.tscn")

@onready var high_score_label: Label = %HighScoreLabel
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	var high_score: int = Global.save_data.high_score
	high_score_label.text = "High Score: " + str(high_score)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAMEPLAY_SCN)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
