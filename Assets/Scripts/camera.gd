extends Camera2D

@onready var current_item_gui = $TextureRect;

func _process(_delta: float) -> void:
	if GameManager.player_inventory == null:
		current_item_gui.visible = false;
	else:
		current_item_gui.visible = true;
