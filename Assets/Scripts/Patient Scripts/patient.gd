extends Node2D
@onready var chat_bubble: Node2D = $ChatBubble
@onready var label: Label = $Label
@export var speed = 10
# patien_status change after player cure them, false mean not cure yet, true mean cured
@export var patien_status = false
var interactable : bool = false
var queueing : bool = false
var waiting_for_cure : bool = false
@export var queue_point:Vector2 = Vector2(530, 600);
var current_sickness = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_sickness = GameManager.symptoms_combo.pick_random();
	print("Patient Sickness: ", current_sickness);
	chat_bubble.visible = false
	label.visible = false
	position.x = queue_point.x



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(patien_status == false):
		if(position.y > queue_point.y):
			position.y -= speed
	if interactable == true:
		if Input.is_action_just_pressed("Interact"):
			if(!waiting_for_cure):
				label.text = "Press F to take order"
				print("Player took customer's order")
				label.visible = false
				chat_bubble.play_symptom_anim();
				await get_tree().create_timer(2.0).timeout
				chat_bubble.visible = false
				waiting_for_cure = true
			else:
				label.text = "Press F to give medicine"
				serve_medicine();


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		label.visible = true
		interactable = true
	elif(body.is_in_group("Patient")):
		print("Patient hit patient")
		speed = 0
		queueing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		label.visible = false
		interactable = false
	if(body.is_in_group("Patient")):
		speed = 10

func serve_medicine() -> void:
	pass
