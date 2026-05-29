extends Control

@onready var label: Label = $Label;
@onready var anim: AnimatedSprite2D = $"Coin Sprite";

func _ready() -> void: 
	anim.play("idle");

func _process(_delta: float) -> void:
	label.text = str(GameManager.player_score);
