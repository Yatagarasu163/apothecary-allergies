extends Control

@export var upgrades: Array[AnimatedSprite2D] = [];
@onready var label = $Label
@onready var button = $Add3;

func _process(_delta: float) -> void:
	if GameManager.upgrades[GameManager.upgrade_category.TABLE] == 8:
		button.visible = false;
	if GameManager.upgrades[GameManager.upgrade_category.TABLE] == 0:
		for upgrade in upgrades:
			upgrade.play("no_upgrade");
	else:
		for upgrade in upgrades:
			if upgrades.find(upgrade) < GameManager.upgrades[GameManager.upgrade_category.TABLE]:
				upgrade.play("yes_upgrade");
			else:
				upgrade.play("no_upgrade");
	label.text = str(GameManager.upgrade_prices[GameManager.upgrade_category.TABLE][GameManager.upgrades[GameManager.upgrade_category.TABLE]]);
