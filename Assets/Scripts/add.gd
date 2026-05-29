extends Button

@onready var anim = $AnimatedSprite2D;
@export var type: GameManager.upgrade_category;

func _ready() -> void:
	anim.play("idle");

func mouse_entered() -> void:
	anim.play("hover");

func mouse_exited() -> void:
	anim.play("idle");
	
func mouse_pressed() -> void:
	anim.play("pressed");
	print(GameManager.player_score >= GameManager.upgrade_prices[type][GameManager.upgrades[type]]);
	print(GameManager.upgrade_prices[type][GameManager.upgrades[type]])
	if GameManager.player_score >= GameManager.upgrade_prices[type][GameManager.upgrades[type]] && GameManager.upgrades[type] < GameManager.max_upgrades[type]:
		GameManager.player_score -= GameManager.upgrade_prices[type][GameManager.upgrades[type]];
		print(GameManager.player_score);
		GameManager.upgrades[type] += 1;
		print(GameManager.upgrades[type]);
