extends Control

@onready var symptom_1_sprite = $"Symptom 1";
@onready var symptom_2_sprite = $"Symptom 2";

func _ready() -> void:
	symptom_1_sprite.visible = false;
	symptom_2_sprite.visible = false;

func _process(_delta: float) -> void:
	if (GameManager.current_sickness.size() > 0):
		visible = true;
		if (GameManager.current_sickness.size() == 1):
			symptom_1_sprite.position.y = 135;
			symptom_1_sprite.texture = GameManager.symptom_sprites[GameManager.current_sickness[0]];
			symptom_1_sprite.visible = true;
		else:
			symptom_1_sprite.position.y = 90;
			symptom_1_sprite.texture = GameManager.symptom_sprites[GameManager.current_sickness[0]];
			symptom_2_sprite.position.y = 180;
			symptom_2_sprite.texture = GameManager.symptom_sprites[GameManager.current_sickness[1]];
			symptom_1_sprite.visible = true;
			symptom_2_sprite.visible = true;
