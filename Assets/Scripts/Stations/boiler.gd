extends Node2D

# EDITABLE VARIABLES
var boiling_timer: float = 5.0; 
@export var base_boiling_timer: float = 5.0;
@export var interaction_range: float = 2.0;
@export var audio: AudioStreamPlayer

# VARIABLES
var is_player_inside: bool = false;
var total_visible_items: int = 0;
var item_to_boil = null;
var has_boiled = false;

@onready var light: PointLight2D = $PointLight2D;

var boiled_versions = {
	GameManager.items.NYAA_LEAF: GameManager.items.BOILED_NYAA_LEAF,
	GameManager.items.STAR_FLOWER: GameManager.items.BOILED_STAR_FLOWER,
	GameManager.items.OOF_ROCK: GameManager.items.BOILED_OOF_ROCK,
	GameManager.items.DRAGON_SCALE: GameManager.items.BOILED_DRAGON_SCALE,	
}

# INTERACTION AREA
@onready var interactable_area = $"Collision Detector/CollisionShape2D";

# ITEMS
@onready var item = $Items/Item;

# SPRITES
@onready var boiler_sprite: AnimatedSprite2D = $"Boiler Sprite";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_visible_items = 0;
	boiler_sprite.play("Idle");
	z_index = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_item_visibility();
	check_player_interaction();
	boiling_timer = base_boiling_timer - (0.5 * GameManager.upgrades[GameManager.upgrade_category.BOILER]);

func body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;

func boil_item() -> void:
	if boiled_versions.has(item_to_boil):
		print("Interacting with the boiler!");
		total_visible_items = 0;
		boiler_sprite.play("Using");
		audio.pitch_scale = randf_range(0.5, 1.5);
		audio.play(2)
		await get_tree().create_timer(boiling_timer).timeout;
		audio.stop()
		boiler_sprite.play("Idle");
		print("Boiled an item!");
		item_to_boil = boiled_versions[item_to_boil];
		print(item_to_boil);
		item.texture = GameManager.items_sprites[item_to_boil];
		total_visible_items = 1;
	else:
		print("Uh oh, that item is already boiled!");

	
func check_item_visibility() -> void:
	match total_visible_items:
		0: 
			item.visible = false;
		1:
			item.visible = true;

func check_player_interaction() -> void: 
	if is_player_inside:
		if Input.is_action_just_pressed("Add"):
			if total_visible_items < 1 && GameManager.player_inventory != null:
				total_visible_items = 1;
				item_to_boil = GameManager.player_inventory;
				item.texture = GameManager.items_sprites[item_to_boil];
				GameManager.player_inventory = null;
				print("Adding item!");
			elif total_visible_items > 0 && GameManager.player_inventory == null:
				total_visible_items = 0;
				GameManager.player_inventory = item_to_boil;
				GameManager.player_inventory_sprite = GameManager.items_sprites\
				[GameManager.player_inventory];
				item_to_boil = null;
				print("Taken item from the boiler!");
				has_boiled = false;
		elif Input.is_action_just_pressed("Interact") && has_boiled == false:
			boil_item();
			has_boiled = true;
