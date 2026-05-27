extends Node2D
@onready var chat_bubble: Node2D = $ChatBubble
@onready var label: Label = $Label
@export var speed = 10
@export var patien_status = false # patien_status change after player cure them, false mean not cure yet, true mean cured

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chat_bubble.visible = false
	label.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(patien_status == false):
		if(position.y != 275):
			position.y = 275
		if(position.x > 900):
			position.x -= speed
