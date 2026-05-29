extends Control

@export var upgrades: Array[AnimatedSprite2D] = [];

func _process(_delta: float) -> void:
	if GameManager.upgrades[GameManager.upgrade_category.BOILER] == 0:
		for upgrade in upgrades:
			upgrade.play("no_upgrade");
	else:
		for upgrade in upgrades:
			if upgrades.find(upgrade) < GameManager.upgrades[GameManager.upgrade_category.BOILER]:
				upgrade.play("yes_upgrade");
			else:
				upgrade.play("no_upgrade");
