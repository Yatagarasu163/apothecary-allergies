extends Node2D

@export var tables:Array[Node2D] = [];

func _process(_delta: float) -> void:
	for table in tables:
		if tables.find(table) + 1 <= GameManager.upgrades[GameManager.upgrade_category.TABLE]:
			table.visible = true;
		else:
			table.visible = false;
