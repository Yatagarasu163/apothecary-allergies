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
@export var yeepee_point:Vector2 = Vector2(1399.0, 300.0)
var current_sickness = null;


@export var CharacterSprite: Node2D
@export var HeadSprite: Sprite2D
@export var BodySprite: Sprite2D
@export var BuffMiawSprite: AnimatedSprite2D
@export var FireEyesSprite: AnimatedSprite2D
@export var CoughinStarsSprite: AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RandomizePatientType()
	
	current_sickness = GameManager.symptoms_combo.pick_random();
	print("Patient Sickness: ", current_sickness);
	for symptom in current_sickness:
		CheckSymptoms(symptom)
	
	chat_bubble.visible = false
	label.visible = false
	position.x = queue_point.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_patient_status();
	if interactable == true:
		if Input.is_action_just_pressed("Interact"):
			if(!waiting_for_cure):
				label.visible = false
				chat_bubble.play_symptom_anim();
				await get_tree().create_timer(2.0).timeout
				chat_bubble.visible = false
				waiting_for_cure = true
				#GameManager.current_sickness = current_sickness;
			else:
				serve_medicine();


func CheckSymptoms(symptoms: int):
	match symptoms:
		GameManager.symptoms.BUFF_CAT:
			BuffMiawSprite.visible = true
			BuffMiawSprite.play("active")
		GameManager.symptoms.FIRE_EYES:
			FireEyesSprite.visible = true
			FireEyesSprite.play("active")
		GameManager.symptoms.UPSIDE_DOWN:
			CharacterSprite.rotation = deg_to_rad(180)
		GameManager.symptoms.STARRY_COUGH:
			CoughinStarsSprite.visible = true
			CoughinStarsSprite.play("active")


func RandomizePatientType():
	var frame_x: int = randi() % 4
	var frame_coord: Vector2 = Vector2(frame_x, 0)
	HeadSprite.frame_coords = frame_coord
	frame_x = randi() % 4
	frame_coord = Vector2(frame_x, 1)
	BodySprite.frame_coords = frame_coord


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		interactable = true
		if(!waiting_for_cure):
			label.text = "Press F to take order"
			label.visible = true
		else:
			label.text = "Press F to give medicine"
	elif(body.is_in_group("Patient")):
		speed = 0
		queueing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player") && queueing == false):
		label.visible = false
		interactable = false
	if(body.is_in_group("Patient")):
		speed = 10
		queueing = false

func serve_medicine() -> void:
	var given_medicine = GameManager.player_inventory;
	var key = GameManager.antidote_combo[current_sickness];
	print(key);
	if(given_medicine == key):
		print("Taken the right cure!");
		GameManager.player_inventory = null;
		GameManager.player_inventory_sprite = null;
		patien_status = true;
	else:
		label.text = "That's not my allergy!";
		label.visible = true;
		await get_tree().create_timer(2.0).timeout;
		label.visible = false;

func check_patient_status() -> void:
	if(patien_status == false):
		if(position.y > queue_point.y):
			position.y -= speed
	else:
		if(position.x < yeepee_point.x):
			position.x += speed
		elif(position.y > yeepee_point.y):
			position.y -= speed
		else:
			queue_free();
			GameManager.amount_of_patient_on_screen -= 1
