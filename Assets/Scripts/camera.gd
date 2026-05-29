extends Camera2D
class_name CameraControl

@export var camMoveSpeed: float = 15
@onready var current_item_gui = $"CanvasLayer/Control/ItemBoxIcon/Item Icon";
@onready var coin_label = $"CanvasLayer/Coin Score/Coin Count";
@onready var coin_anim = $"CanvasLayer/Coin Score/Coin";
var currentTargetPosition: Vector2

func _ready() -> void:
	coin_anim.play("spin");

func _process(_delta: float) -> void:
	if GameManager.player_inventory == null:
		current_item_gui.visible = false;
	else:
		current_item_gui.texture = GameManager.player_inventory_sprite;
		current_item_gui.visible = true;
	position = lerp(position, currentTargetPosition, camMoveSpeed * _delta);
	coin_label.text = str(GameManager.player_score);

func setNewPosition(newPosition: Vector2):
	currentTargetPosition = newPosition
