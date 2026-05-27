extends CharacterBody2D;

@export_category("Movement")
@export var base_speed: int = 350;
@export var dash_speed: int = 600;
@export var dash_duration: float = 0.01;
@export var dash_cooldown: float = 3.0;
var current_dash_cooldown: float = 0.0;

@onready var anim := $"Player Sprite"

var walkedRight: bool = true
var walkedDown: bool = true
var moveDirection: Vector2

func handleInput():
	moveDirection = Input.get_vector("WalkLeft","WalkRight","WalkUp","WalkDown")
	velocity = moveDirection * base_speed;
	
	if Input.is_action_just_pressed("Dash") && current_dash_cooldown <= 0:
		current_dash_cooldown = dash_cooldown;
		velocity = moveDirection * dash_speed;
		await get_tree().create_timer(dash_cooldown).timeout;
		velocity = moveDirection * base_speed;

func handleSpriteAnim() -> void:
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
	
	pass

func _physics_process(delta: float) -> void:
	handleInput()
	handleSpriteAnim()
	move_and_slide()
	if current_dash_cooldown > 0:
		current_dash_cooldown -= delta;
