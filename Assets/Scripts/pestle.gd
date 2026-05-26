extends Node2D

# EDITABLE VARIABLES
@export var grinding_timer: float = 3.0; 
@export var interaction_range: float = 2.0;

# VARIABLES
var is_player_inside: bool = false;
var total_visible_items: int = 0;
var has_grinded_item: bool = false;
var items_to_grind = [];

# INTERACTION AREA
@onready var interactable_area = $"Collision Detector/CollisionShape2D";

# ITEMS
@onready var item_1 = $"Items/Item 1";
@onready var item_2 = $"Items/Item 2";
@onready var item_3 = $"Items/Item 3";

# SPRITES
@onready var pestle_sprite: AnimatedSprite2D = $PestleSprite;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_visible_items = 0;
	pestle_sprite.play("idle");
	interactable_area.shape.size = Vector2(100, 100) * interaction_range;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match total_visible_items:
		0: 
			item_1.visible = false;
			item_2.visible = false;
			item_3.visible = false;
		1:
			item_1.position.x = 0;
			item_1.visible = true;
		2:
			item_1.position.x = -12;
			item_2.position.x = 12;
			item_2.visible = true;
		3: 
			item_1.position.x = -24;
			item_2.position.x = 0;
			item_3.position.x = 24;
			item_3.visible = true;
	
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			# Checks if the amount of items is less than 3
			if(total_visible_items < 3):
				# If the pestle has already grinded something, then pick it up
				if(has_grinded_item):
					print("Picked up grinded item!");
					total_visible_items = 0;
					has_grinded_item = false;
				# Else, then it is just the player adding another item to the grinder.
				else:
					print("Adding an item!");
					add_item(GameManager.player_inventory);
					total_visible_items += 1;
			else:
				print("You cannot add anymore items!");
		elif Input.is_action_just_pressed("Interact"):
			print("Interacting with the grinder!");
			total_visible_items = 0;
			await get_tree().create_timer(grinding_timer).timeout;
			total_visible_items = 1;
			has_grinded_item = true;

func body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
	
func add_item(item) -> void:
	if GameManager.player_inventory != null:
		var current_item = null;
		match total_visible_items:
			0:
				current_item = item_1;
			1:
				current_item = item_2;
			2: 
				current_item = item_3;
			
		current_item.texture = GameManager.items_sprites(GameManager.player_inventory);
		items_to_grind.append(GameManager.player_inventory);
	else:
		print("No item to add to the pestle!");

func grind_items() -> void:
	if items_to_grind.size() > 0:
		if items_to_grind.has(GameManager.items.BOILED_NYAA_LEAF) && items_to_grind.has(GameManager.items.OOF_ROCK) && items_to_grind.size() == 2:
			print("Grinded the Buff Cat Cure!");
		if items_to_grind.has(GameManager.items.BOILED_STAR_FLOWER) && items_to_grind.has(GameManager.items.BOILED_DRAGON_SCALE) && items_to_grind.size() == 2:
			print("Grinded the Upside-down Cure!");
	
			
	pass;
