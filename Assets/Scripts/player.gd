extends CharacterBody2D;

@export var base_speed: int = 35;
@export var dash_speed: int = 750
@export var dash_cooldown: float = 1;
@export var slippery: float = 10
var current_dash_cooldown: float = 0.0;

@onready var anim := $"Player Sprite"
@onready var light := $PointLight2D;
@onready var next_day_text: Label = $NextDayText

#FOR PLAYER NODE TO FIND PATIENT_SPAWNER IN A SCENE
@onready var patient_spawner: Node2D = $"../Shop Layout/Patient_Spawner"

var walkedRight: bool = true
var walkedDown: bool = true
var moveDirection: Vector2

func handleInput():
	velocity = lerp(velocity, Vector2.ZERO, 1 / slippery)
	
	moveDirection = Input.get_vector("WalkLeft","WalkRight","WalkUp","WalkDown")
	velocity += moveDirection * base_speed;
	
	if Input.is_action_just_pressed("Dash") && current_dash_cooldown <= 0:
		current_dash_cooldown = dash_cooldown;
		velocity += moveDirection * dash_speed;
		await get_tree().create_timer(dash_cooldown).timeout;

func handleSpriteAnim() -> void:
	z_index = position.y
	
	if Input.is_action_just_pressed("WalkRight"): walkedRight = true
	if Input.is_action_just_pressed("WalkLeft"): walkedRight = false
	if Input.is_action_just_pressed("WalkDown"): walkedDown = true
	if Input.is_action_just_pressed("WalkUp"): walkedDown = false
	
	var animName: String = ""
	if moveDirection != Vector2.ZERO: animName = "Walk_"
	else: animName = "Idle_" 
	if walkedRight: animName += "Right"
	else: animName += "Left"
	if walkedDown: animName += "Front"
	else: animName += "Back"
	
	anim.play(animName)

func goToNextDay()->void:
	if(GameManager.amount_of_patient_spawn == GameManager.maximum_amount_of_patient 
	&& GameManager.amount_of_patient_on_screen == 0):
		next_day_text.text = "Press enter to go to next day";
		next_day_text.visible = true
		if(Input.is_action_just_pressed("Enter")):
			print("Tomorrow will be another day")
			GameManager.day += 1;
			if(GameManager.day <= 3):
				GameManager.maximum_amount_of_patient = randi_range(3, 5);
				GameManager.amount_of_patient_spawn = 0;
			next_day_text.visible = false
			print("Max amnt of patient: ",GameManager.maximum_amount_of_patient)
			print("Amnt of patient spawn: ",GameManager.amount_of_patient_spawn)
			patient_spawner.start_next_day()
	else:
		next_day_text.visible = false

func _physics_process(delta: float) -> void:
	handleInput()
	handleSpriteAnim()
	goToNextDay()
	move_and_slide()
	if current_dash_cooldown > 0:
		current_dash_cooldown -= delta;
