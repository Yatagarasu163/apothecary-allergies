extends Camera2D
class_name CameraControl

@export var camMoveSpeed: float = 15
@export var curtainSpeed: float = 5
@export var openCurtainY: float = -1050

@onready var current_item_gui = $"Book/Control/ItemBoxIcon/Item Icon";
@onready var curtain = $"Book/Control/UI Banner"
@onready var coin_label = $"Book/Coin Score/Coin Count";
@onready var coin_anim = $"Book/Coin Score/Coin";
@onready var canvas_layer = $Letter;
@onready var ui_layer = $Book;
@onready var start_anim = $Letter/Control/Start/AnimatedSprite2D;
@onready var pause_menu := $"Pause Menu"
var currentTargetPosition: Vector2

func _ready() -> void:
	if GameManager.day < 2:
		ui_layer.visible = false;
		canvas_layer.visible = true;
	else:
		ui_layer.visible = true;
		canvas_layer.visible = false;
	coin_anim.play("spin");
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pause_menu.TogglePause()
	
	if GameManager.player_inventory == null:
		current_item_gui.visible = false;
	else:
		current_item_gui.texture = GameManager.player_inventory_sprite;
		current_item_gui.visible = true;
	position = lerp(position, currentTargetPosition, camMoveSpeed * _delta);
	
	if GameManager.newDaying:
		curtain.position.y = lerp(curtain.position.y, 0.0, curtainSpeed / 10)
		currentTargetPosition = Vector2(0,-65)
	else: 
		curtain.position.y = lerp(curtain.position.y, openCurtainY, curtainSpeed / 10)
	
	coin_label.text = str(GameManager.player_score);

func setNewPosition(newPosition: Vector2):
	currentTargetPosition = newPosition

func _on_start_mouse_entered() -> void:
	start_anim.play("hover");

func _on_start_mouse_exited() -> void:
	start_anim.play("idle");
