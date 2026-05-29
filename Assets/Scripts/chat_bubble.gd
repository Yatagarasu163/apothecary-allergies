extends Node2D

enum symptoms {BUFF_CAT, UPSIDE_DOWN, FIRE_EYES};
@export var symptom_list: Array[symptoms]; 
var symptom_list_textures: Array[Texture] = [
	preload("res://icon.svg"),
];
@onready var symptom_sprite = $SymptomSprite;

@export var symptom_display_delay: float = 6.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_symptom_anim();

func play_symptom_anim() -> void:
	print("PLAYING SYMPTOM ANIM")
	visible = true;
	for symptom in GameManager.current_sickness:
		symptom_sprite.texture = GameManager.symptom_sprites[symptom];
		symptom_sprite.visible = true;
		match symptom:
			symptoms.BUFF_CAT:
				#symptom_sprite.texture = symptom_list_textures[symptoms.BUFF_CAT];
				print("BUFF_CAT");
			symptoms.UPSIDE_DOWN:
				#symptom_sprite.texture = symptom_list_textures[symptoms.UPSIDE_DOWN];
				print("UPSIDE_DOWN");
			symptoms.FIRE_EYES:
				#symptom_sprite.texture = symptom_list_textures[symptoms.FIRE_EYES];
				print("FIRE_EYES");
			_:
				#symptom_sprite.texture = symptom_list_textures[symptoms.BUFF_CAT];
				print("DEFAULT");
		await get_tree().create_timer(symptom_display_delay).timeout;
		symptom_sprite.visible = false;
		await get_tree().create_timer(symptom_display_delay).timeout;
	visible = false;
