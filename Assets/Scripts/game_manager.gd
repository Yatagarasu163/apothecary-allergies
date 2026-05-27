extends Node2D;

# ITEM ENUMS AND SPRITES
enum items {NYAA_LEAF, STAR_FLOWER, OOF_ROCK, DRAGON_SCALE, 
			BOILED_NYAA_LEAF, BOILED_STAR_FLOWER, BOILED_OOF_ROCK,
			BOILED_DRAGON_SCALE, RUBBISH};
enum antidotes {DE_MEOWER, DE_NNERBONE, WATERY_WOOFER, A_SACK_O_ONIONS,
				UNMEOWING_DE_NNERBONE}
@onready var items_sprites: Array[Texture] = [
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
]
@onready var antidote_sprites: Array[Texture] = [
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
]

# PLAYER_INVENTORY
var player_inventory = null;
var player_inventory_sprite = null;

# RECIPES
var recipes = {
	sort_recipe_key([items.BOILED_NYAA_LEAF, items.OOF_ROCK]): antidotes.DE_MEOWER,
	sort_recipe_key([items.BOILED_STAR_FLOWER, items.BOILED_DRAGON_SCALE]): antidotes.DE_NNERBONE,
	sort_recipe_key([items.NYAA_LEAF, items.BOILED_OOF_ROCK, items.STAR_FLOWER]): antidotes.WATERY_WOOFER,
	sort_recipe_key([items.DRAGON_SCALE]): antidotes.A_SACK_O_ONIONS,
	sort_recipe_key([items.BOILED_STAR_FLOWER, 
	items.BOILED_DRAGON_SCALE, items.BOILED_NYAA_LEAF]): antidotes.UNMEOWING_DE_NNERBONE
};

func sort_recipe_key(recipe: Array) -> Array:
	var sorted = recipe.duplicate();
	sorted.sort();
	return sorted;
