extends Node2D
@onready var chat_bubble: Node2D = $ChatBubble
@onready var label: Label = $Label
@export var speed = 10
# patien_status change after player cure them, false mean not cure yet, true mean cured
@export var patien_status = false
var interactable : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chat_bubble.visible = false
	label.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(patien_status == false):
		if(position.y != 505):
			position.y = 505
		if(position.x > 1140):
			position.x -= speed
	if interactable == true && Input.is_action_just_pressed("Interact"):
		print("Player took customer's order")
		label.visible = false
		chat_bubble.visible = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		label.visible = true
		interactable = true
		label.text = "Press F to take order"
	elif(body.is_in_group("Patient")):
		print("Patient hit patient")
		speed = 0
