extends Node2D;

# ITEM ENUMS AND SPRITES
enum items {NYAA_LEAF, 
			STAR_FLOWER, 
			OOF_ROCK, 
			DRAGON_SCALE, 
			
			BOILED_NYAA_LEAF, 
			BOILED_STAR_FLOWER, 
			BOILED_OOF_ROCK,
			BOILED_DRAGON_SCALE, 
			
			RUBBISH,
			
			DE_MEOWER, 
			DE_NNERBONE, 
			WATERY_WOOFER, 
			A_SACK_O_ONIONS,
			UNMEOWING_DE_NNERBONE
			};
@onready var items_sprites: Array[Texture] = [
	preload("res://Assets/Sprites/Ingredients/nyaa_leaf.png"),
	preload("res://Assets/Sprites/Ingredients/star_flower.png"),
	preload("res://Assets/Sprites/Ingredients/oof_rock.png"),
	preload("res://Assets/Sprites/Ingredients/dragon_scale.png"),
	
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	
	preload("res://icon.svg"),
	
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://icon.svg"),
	preload("res://Assets/Sprites/Antidote/sack-of-onions.png"),
	preload("res://icon.svg"),
]

# PLAYER_INVENTORY
var player_inventory = null;
var player_inventory_sprite = null;

# RECIPES
var recipes = {
	sort_recipe_key([items.BOILED_NYAA_LEAF, items.OOF_ROCK]): items.DE_MEOWER,
	sort_recipe_key([items.BOILED_STAR_FLOWER, items.BOILED_DRAGON_SCALE]): items.DE_NNERBONE,
	sort_recipe_key([items.NYAA_LEAF, items.BOILED_OOF_ROCK, items.STAR_FLOWER]): items.WATERY_WOOFER,
	sort_recipe_key([items.DRAGON_SCALE]): items.A_SACK_O_ONIONS,
	sort_recipe_key([items.BOILED_STAR_FLOWER, 
	items.BOILED_DRAGON_SCALE, items.BOILED_NYAA_LEAF]): items.UNMEOWING_DE_NNERBONE
};

# SYMPTOMS
enum symptoms {
	BUFF_CAT,
	FIRE_EYES,
	UPSIDE_DOWN,
	STARRY_COUGH
}

@onready var symptom_sprites: Array[Texture] = [
	
]

var symptoms_combo = [[symptoms.BUFF_CAT], [symptoms.UPSIDE_DOWN], [symptoms.FIRE_EYES, 
symptoms.BUFF_CAT], [symptoms.FIRE_EYES], [symptoms.UPSIDE_DOWN, symptoms.BUFF_CAT],
[symptoms.STARRY_COUGH]];

func sort_recipe_key(recipe: Array) -> Array:
	var sorted = recipe.duplicate();
	sorted.sort();
	return sorted;
