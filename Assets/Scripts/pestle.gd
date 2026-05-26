extends Node2D


@onready var item_1 = $"Items/Item 1";
@onready var item_2 = $"Items/Item 2";
@onready var item_3 = $"Items/Item 3";

@export var grinding_timer: float = 3.0; 

var is_player_inside: bool = false;
var total_visible_items: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_visible_items = 0;

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
			print("Adding an item!");
			if(total_visible_items < 3):
				total_visible_items += 1;
			else:
				print("You cannot add anymore items!");
		elif Input.is_action_just_pressed("Interact"):
			print("Interacting with the grinder!");
			total_visible_items = 0;
			await get_tree().create_timer(grinding_timer).timeout;
			total_visible_items = 1;

func body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
	
