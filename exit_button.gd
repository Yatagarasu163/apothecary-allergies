extends Button

@onready var anim = $AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle");

func mouse_entered() -> void:
	anim.play("hover");

func mouse_exited() -> void:
	anim.play("idle");
	
func mouse_pressed() -> void:
	anim.play("pressed");

func _on_exit_button_pressed():
	get_tree().quit()
