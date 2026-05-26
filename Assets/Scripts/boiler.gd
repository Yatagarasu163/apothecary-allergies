extends Node2D

# EDITABLE VARIABLES
@export var boiling_timer: float = 3.0; 
@export var interaction_range: float = 2.0;

# VARIABLES
var is_player_inside: bool = false;
var total_visible_items: int = 0;
var has_boiled_item: bool = false;

# INTERACTION AREA
@onready var interactable_area = $"Collision Detector/CollisionShape2D";

# ITEMS
@onready var item = $Items/Item;

# SPRITES
@onready var boiler_sprite: AnimatedSprite2D = $"Boiler Sprite";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_visible_items = 0;
	boiler_sprite.play("idle");
	interactable_area.shape.size = Vector2(100, 100) * interaction_range;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match total_visible_items:
		0: 
			item.visible = false;
		1:
			item.position.x = 0;
			item.position.y = -50;
			item.scale = 0.5;
			item.visible = true;
	
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			if total_visible_items < 1:
				if has_boiled_item:
					total_visible_items = 0;
					print("Taken boiled item!");
				else:
					total_visible_items = 1;
					print("Adding item!");
		elif Input.is_action_just_pressed("Interact"):
			print("Interacting with the boiler!");
			total_visible_items = 0;
			await get_tree().create_timer(boiling_timer).timeout;
			total_visible_items = 1;
			has_boiled_item = true;

func body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
	
