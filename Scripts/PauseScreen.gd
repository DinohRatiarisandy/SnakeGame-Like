class_name PauseScn extends CanvasLayer

"""
	Class for paused game.
"""

@onready var resume_btn: Button = %ResumeButton
@onready var restart_btn: Button = %RestartButton


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.queue_free()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false


func _on_resume_button_pressed() -> void:
	self.queue_free()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
