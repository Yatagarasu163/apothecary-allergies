extends Node2D

@export var interaction_range: float = 100.0;
@export var item_provider: GameManager.items;

@onready var interactable_area = $"Collision Detector/CollisionShape2D"

var is_player_inside: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_area.shape.size = Vector2(100, 100) * interaction_range;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			print("Taking an item!");
			if GameManager.player_inventory == null:
				GameManager.player_inventory = item_provider;
				GameManager.player_inventory_sprite = GameManager.items_sprites\
				[item_provider];
			else:
				print("You already have something!");

func body_entered(_body: Node2D) -> void:
	is_player_inside = true;

func body_exited(_body: Node2D) -> void:
	is_player_inside = false;
