extends Camera2D
class_name CameraControl

@export var camMoveSpeed: float = 15
@export var curtainSpeed: float = 5
@export var openCurtainY: float = -1050

@onready var current_item_gui = $"CanvasLayer/Control/ItemBoxIcon/Item Icon";
@onready var item_box = $CanvasLayer/Control/ItemBoxIcon
@onready var curtain = $"CanvasLayer/Control/UI Banner"
var currentTargetPosition: Vector2

func _process(_delta: float) -> void:
	if GameManager.player_inventory == null:
		current_item_gui.visible = false;
	else:
		current_item_gui.texture = GameManager.player_inventory_sprite;
		current_item_gui.visible = true;
	position = lerp(position, currentTargetPosition, camMoveSpeed * _delta)
	
	if GameManager.nextDaying:
		curtain.position.y = lerp(curtain.position.y, 0.0, curtainSpeed / 10)
		currentTargetPosition = Vector2(0,-65)
	else: 
		curtain.position.y = lerp(curtain.position.y, openCurtainY, curtainSpeed / 10)

func setNewPosition(newPosition: Vector2):
	currentTargetPosition = newPosition
