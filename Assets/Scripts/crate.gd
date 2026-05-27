extends Node2D

@export var interaction_range: float = 100.0;
@export var item_provider: GameManager.items;

@onready var interactable_area = $"Collision Detector/CollisionShape2D"

var is_player_inside: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_inside && GameManager.player_inventory == null && \
	Input.is_action_just_pressed("Add"):
		print("Taking an item!");
		GameManager.player_inventory = item_provider;
		GameManager.player_inventory_sprite = GameManager.items_sprites\
		[item_provider];

func body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
