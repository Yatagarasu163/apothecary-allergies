extends Node2D

# EDITABLE VARIABLES
var grinding_timer: float = 3.0; 
@export var base_grinding_timer: float = 5.0;
@export var interaction_range: float = 2.0;
@export var audio: AudioStreamPlayer

# VARIABLES
var is_player_inside: bool = false;
var total_visible_items: int = 0;
var has_grinded_item: bool = false;
var items_to_grind = [];

@onready var light: PointLight2D= $PointLight2D;

# INTERACTION AREA
@onready var interactable_area = $"Collision Detector/CollisionShape2D";
@onready var anim = $PestleSprite;

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
	z_index = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_item_visibility();
	check_player_interaction();
	grinding_timer = base_grinding_timer - (0.5 * GameManager.upgrades[GameManager.upgrade_category.PESTLE]);
	

func body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;

func add_item() -> void:
	if GameManager.player_inventory == null:
		print("No item to add to the pestle!");
	elif GameManager.player_inventory < GameManager.items.RUBBISH:
		print("Adding an item!");
		var current_item = null;
		match total_visible_items:
			0: current_item = item_1;
			1: current_item = item_2;
			2: current_item = item_3;
		current_item.texture = GameManager.items_sprites[GameManager.player_inventory];
		items_to_grind.append(GameManager.player_inventory);
		GameManager.player_inventory = null;
		total_visible_items += 1;
	elif GameManager.player_inventory >= GameManager.items.RUBBISH:
		print("You cannot add that item!");

func grind_items() -> void:
	if items_to_grind.size() < 1:
		print("Not enough items to grind!")
		return
	
	var key = get_recipe_key(items_to_grind);

	print("Interacting with the grinder!");
	total_visible_items = 0;
	var current_item = null;

	if GameManager.recipes.has(key):
		print("Crafted:", GameManager.recipes[key]);
		match GameManager.recipes[key]:
			GameManager.items.DE_MEOWER:
				print("Made a De-Meower!");
			GameManager.items.DE_NNERBONE:
				print("Made a De-nnerbone!");
			GameManager.items.WATERY_WOOFER:
				print("Made a Watery Woofer!");
			GameManager.items.A_SACK_O_ONIONS:
				print("Made A Sack O' Onions!");
			GameManager.items.UNMEOWING_DE_NNERBONE:
				print("Made an Unmeowing De-nnerbone!");
			_:
				print("That recipe doesn't exist!");
		item_1.texture = GameManager.items_sprites[GameManager.recipes[key]];
		current_item = GameManager.recipes[key];
	else:
		print("Uh Oh, that wasn't a real recipe!");
		item_1.texture = GameManager.items_sprites[GameManager.items.RUBBISH];
		current_item = GameManager.items.RUBBISH;
	
	anim.play("grinding"); 
	audio.pitch_scale = randf_range(0.5, 1.5);
	audio.play(3)
	await get_tree().create_timer(grinding_timer).timeout;
	audio.stop()
	anim.play("idle");
	total_visible_items = 1;
	has_grinded_item = true;
	items_to_grind = [current_item];
	
func get_recipe_key(items: Array) -> Array:
	var sorted = items.duplicate();
	sorted.sort();
	return sorted;

func check_item_visibility() -> void:
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
			
func check_player_interaction() -> void:
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			# Checks if the amount of items is less than 3
			if(total_visible_items < 3):
				# If the pestle has already grinded something, then pick it up
				if has_grinded_item and items_to_grind[0] > GameManager.items.RUBBISH:
					if GameManager.player_inventory == null:
						print("Picked up grinded item!");
						total_visible_items = 0;
						GameManager.player_inventory = items_to_grind[0];
						if GameManager.player_inventory != GameManager.items.RUBBISH:
							GameManager.player_inventory_sprite = GameManager.items_sprites\
							[GameManager.player_inventory];
						else:
							GameManager.player_inventory_sprite = GameManager.items_sprites\
							[GameManager.items.RUBBISH];
						items_to_grind = [];
					else:
						print("Player already has an item!");
						return;
					has_grinded_item = false;
				# Else, then it is just the player adding another item to the grinder.
				else:
					add_item();
			else:
				print("You cannot add anymore items!");
		elif Input.is_action_just_pressed("Interact"):
			grind_items();
