extends Node2D


var is_player_inside: bool = false;
@onready var anim: AnimatedSprite2D = $"Rubbish Sprite"

func _ready() -> void:
	anim.play("idle");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			GameManager.player_inventory = null;
			GameManager.player_inventory_sprite = null;
			anim.play("burning");
			await get_tree().create_timer(2.0).timeout;
			anim.play("idle");

func body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
