extends Node2D;

var player_score: int = 0;

#THESE VAR IS USE FOR PATIENT SPAWNER
# DETECT THE AMOUNT OF PATIENT ON SCREEN (FOR PATIENT_SPAWNER)
var amount_of_patient_on_screen = 0;
#TO LIMIT HOW MANY PATIENTS WE HAVE IN ONE DAY
var maximum_amount_of_patient = 0;
#TO DETECT HOW MANY PATIENT HAS SPAWN ON THAT DAY
var amount_of_patient_spawn = 0;
# DAY COUNTER
var day = 1

# ITEM ENUMS AND SPRITES
enum items {NYAA_LEAF, 
			STAR_FLOWER, 
			OOF_ROCK, 
			DRAGON_SCALE,
			OOF_POWDER, 
			
			BOILED_NYAA_LEAF, 
			BOILED_STAR_FLOWER, 
			BOILED_OOF_ROCK,
			BOILED_DRAGON_SCALE, 
			
			RUBBISH,
			
			DE_MEOWER, 
			DE_NNERBONE, 
			WATERY_WOOFER, 
			A_SACK_O_ONIONS,
			UNMEOWING_DE_NNERBONE,
			HONEY_ITS_A_ROCK,
			UNMEWING_PENICILLIN
			};
@onready var items_sprites: Array[Texture] = [
	preload("res://Assets/Sprites/Ingredients/nyaa_leaf.png"),
	preload("res://Assets/Sprites/Ingredients/star_flower.png"),
	preload("res://Assets/Sprites/Ingredients/oof_rock.png"),
	preload("res://Assets/Sprites/Ingredients/dragon_scale.png"),
	preload("res://Assets/Sprites/Processed Ingredient/oof_powder.png"),
	
	preload("res://Assets/Sprites/Processed Ingredient/boiled_nyaa_leaf.png"),
	preload("res://Assets/Sprites/Processed Ingredient/boiled_star_flower.png"),
	preload("res://Assets/Sprites/Processed Ingredient/boiled_oof_rock.png"),
	preload("res://Assets/Sprites/Processed Ingredient/boiled_dragon_scale.png"),
	
	preload("res://Assets/Sprites/ForRubbish.png"),
	
	preload("res://Assets/Sprites/Antidote/De-meower.png"),
	preload("res://Assets/Sprites/Antidote/De-nnerbone.png"),
	preload("res://Assets/Sprites/Antidote/Watery Woofer.png"),
	preload("res://Assets/Sprites/Antidote/sack-of-onions.png"),
	preload("res://Assets/Sprites/Antidote/Unmeowing De-nnerbone.png"),
	preload("res://Assets/Sprites/Antidote/Honey, it's a rock.png"),
	preload("res://Assets/Sprites/Antidote/Unmewing Penicillin.png")
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
	items.BOILED_DRAGON_SCALE, items.BOILED_NYAA_LEAF]): items.UNMEOWING_DE_NNERBONE,
	sort_recipe_key([items.BOILED_NYAA_LEAF, items.OOF_ROCK, items.DRAGON_SCALE]): items.HONEY_ITS_A_ROCK,
	sort_recipe_key([items.OOF_ROCK, items.OOF_ROCK]): items.OOF_POWDER,
	sort_recipe_key([items.OOF_POWDER, items.BOILED_NYAA_LEAF, items.DRAGON_SCALE]): items.UNMEWING_PENICILLIN,	
};

# SYMPTOMS
enum symptoms {
	BUFF_CAT,
	FIRE_EYES,
	UPSIDE_DOWN,
	STARRY_COUGH
}

@onready var symptom_sprites: Array[Texture] = [
	preload("res://Assets/Sprites/Sickness Icons/BuffCat.png"),
	preload("res://Assets/Sprites/Sickness Icons/Fire Eyes.png"),
	preload("res://Assets/Sprites/Sickness Icons/UpsideDownIcon.png"),
	preload("res://Assets/Sprites/Sickness Icons/StarryCough.png")
]


var symptoms_combo = [
	[symptoms.BUFF_CAT], 
	[symptoms.UPSIDE_DOWN], 
	[symptoms.FIRE_EYES, symptoms.BUFF_CAT], 
	[symptoms.FIRE_EYES], 
	[symptoms.UPSIDE_DOWN, symptoms.BUFF_CAT],
	[symptoms.STARRY_COUGH],
	[symptoms.BUFF_CAT, symptoms.STARRY_COUGH]
];

@onready var customer: Texture = preload("res://Assets/Sprites/Sickness Icons/UpsideDownIcon.png");

var antidote_combo = {
	[symptoms.BUFF_CAT]: items.DE_MEOWER, 
	[symptoms.UPSIDE_DOWN]: items.DE_NNERBONE, 
	[symptoms.FIRE_EYES, symptoms.BUFF_CAT]: items.WATERY_WOOFER, 
	[symptoms.FIRE_EYES]: items.A_SACK_O_ONIONS, 
	[symptoms.UPSIDE_DOWN, symptoms.BUFF_CAT]: items.UNMEOWING_DE_NNERBONE,
	[symptoms.STARRY_COUGH]: items.HONEY_ITS_A_ROCK,
	[symptoms.BUFF_CAT, symptoms.STARRY_COUGH]: items.UNMEWING_PENICILLIN,
}

var current_sickness = [];

enum upgrade_category {TABLE, PESTLE, BOILER}

var max_upgrades = {
	upgrade_category.TABLE: 8,
	upgrade_category.PESTLE: 5,
	upgrade_category.BOILER: 5,
}

var upgrades = {
	upgrade_category.TABLE: 5,
	upgrade_category.PESTLE: 0,
	upgrade_category.BOILER: 0
}

var upgrade_prices = {
	upgrade_category.TABLE: [10, 10, 15, 15, 20, 20, 25, 30],
	upgrade_category.PESTLE: [20, 40, 60, 80, 100],
	upgrade_category.BOILER: [30, 50, 70, 90, 110],
}

func sort_recipe_key(recipe: Array) -> Array:
	var sorted = recipe.duplicate();
	sorted.sort();
	return sorted;
