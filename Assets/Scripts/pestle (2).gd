extends Control

@export var upgrades: Array[AnimatedSprite2D] = [];
@onready var label = $Label;
@onready var button = $Add;

func _process(_delta: float) -> void:
	if GameManager.upgrades[GameManager.upgrade_category.PESTLE] == 5:
		button.visible = false;
	if GameManager.upgrades[GameManager.upgrade_category.PESTLE] == 0:
		for upgrade in upgrades:
			upgrade.play("no_upgrade");
	else:
		for upgrade in upgrades:
			if upgrades.find(upgrade) < GameManager.upgrades[GameManager.upgrade_category.PESTLE]:
				upgrade.play("yes_upgrade");
			else:
				upgrade.play("no_upgrade");
	
	label.text = str(GameManager.upgrade_prices[GameManager.upgrade_category.PESTLE][GameManager.upgrades[GameManager.upgrade_category.PESTLE]]);
