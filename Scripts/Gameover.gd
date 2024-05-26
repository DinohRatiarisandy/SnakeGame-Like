class_name Gameover extends CanvasLayer

"""
	This class is responsable of the game over UI.
"""

@onready var score_label: Label = %ScoreLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton
@onready var high_score_label: Label = %HighScoreLabel


func set_score(score: int) -> void:
	score_label.text = "Score: " + str(score)
	if score > Global.save_data.high_score:
		Global.save_data.high_score = score
		Global.save_data.save()
		high_score_label.visible = true


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
