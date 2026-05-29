extends Camera2D
class_name CameraControl

@export var camMoveSpeed: float = 15
@onready var current_item_gui = $"CanvasLayer/Control/ItemBoxIcon/Item Icon";
var currentTargetPosition: Vector2

func _process(_delta: float) -> void:
	if GameManager.player_inventory == null:
		current_item_gui.visible = false;
	else:
		current_item_gui.texture = GameManager.player_inventory_sprite;
		current_item_gui.visible = true;
	position = lerp(position, currentTargetPosition, camMoveSpeed * _delta)

func setNewPosition(newPosition: Vector2):
	currentTargetPosition = newPosition
