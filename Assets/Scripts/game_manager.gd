extends Node2D;

enum items {NYAA_LEAF, STAR_FLOWER, OOF_ROCK, DRAGON_SCALE, 
			BOILED_NYAA_LEAF, BOILED_STAR_FLOWER, BOILED_OOF_ROCK,
			BOILED_DRAGON_SCALE};
@onready var items_sprites: Array[Texture] = [
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
]
var player_inventory = null;
