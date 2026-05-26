extends CharacterBody2D;

@export var base_speed: int = 350;
@export var dash_speed: int = 600;
@export var dash_duration: float = 0.01;
@export var dash_cooldown: float = 3.0;
var current_dash_cooldown: float = 0.0;

func handleInput():
	var moveDirection = Input.get_vector("WalkLeft","WalkRight","WalkUp","WalkDown")
	velocity = moveDirection * base_speed;
	
	if Input.is_action_just_pressed("Dash") && current_dash_cooldown <= 0:
		current_dash_cooldown = dash_cooldown;
		velocity = moveDirection * dash_speed;
		await get_tree().create_timer(dash_cooldown).timeout;
		velocity = moveDirection * base_speed;

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	if current_dash_cooldown > 0:
		current_dash_cooldown -= delta;
