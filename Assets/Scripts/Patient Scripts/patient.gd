extends Node2D
@onready var chat_bubble: Node2D = $ChatBubble
@onready var label: Label = $Label
@export var speed = 10
# patien_status change after player cure them, false mean not cure yet, true mean cured
@export var patien_status = false
var interactable : bool = false
var queueing : bool = false
@export var queue_point:Vector2 = Vector2(530, 600);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chat_bubble.visible = false
	label.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(patien_status == false):
		if(position.y > queue_point.y):
			position.y -= speed
		if(position.x != 530):
			position.x = 530
	if interactable == true && Input.is_action_just_pressed("Interact"):
		print("Player took customer's order")
		label.visible = false
		chat_bubble.play_symptom_anim();


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		label.visible = true
		interactable = true
		label.text = "Press F to take order"
	elif(body.is_in_group("Patient")):
		print("Patient hit patient")
		speed = 0
		queueing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		label.visible = false
		interactable = false
