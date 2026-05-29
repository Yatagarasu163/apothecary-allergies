extends Node2D

var is_player_inside: bool = false;
@onready var item_sprite: Sprite2D = $ItemSprite;
@onready var collider: CollisionShape2D = $StaticBody2D/CollisionShape2D;
var item = null;

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Add") && is_player_inside && visible:
		if item == null && GameManager.player_inventory != null:
			item_sprite.visible = true;
			item_sprite.texture = GameManager.player_inventory_sprite;
			item = GameManager.player_inventory;
			GameManager.player_inventory = null;
			GameManager.player_inventory_sprite = null;
		elif GameManager.player_inventory == null && item != null:
			GameManager.player_inventory = item;
			GameManager.player_inventory_sprite = item_sprite.texture;
			item_sprite.texture = null;
			item = null;
	if visible:
		collider.disabled = false;
	else:
		collider.disabled = true;

func body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
