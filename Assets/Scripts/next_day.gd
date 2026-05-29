extends Button

@onready var anim = $AnimatedSprite2D;

func _ready() -> void:
	anim.play("idle");

func _on_mouse_entered() -> void:
	anim.play("hover");

func _on_mouse_exited() -> void:
	anim.play("idle")

func _on_pressed() -> void:
	anim.play("pressed");
	get_tree().change_scene_to_file("res://Assets/Scenes/testing_scene.tscn");
	GameManager.day += 1;
	print("Game Manager day: ", GameManager.day);
