extends CanvasLayer

@onready var resumeButton := $ColorRect/resume_button/AnimatedSprite2D
@onready var mainButton := $ColorRect/main_menu_button/AnimatedSprite2D

func TogglePause():
	GameManager.isPaused = not GameManager.isPaused
	visible = GameManager.isPaused


func _on_resume_button_pressed() -> void:
	TogglePause()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Main_Level.tscn");
