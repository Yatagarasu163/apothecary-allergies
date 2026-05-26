extends CharacterBody2D

@export var speed: int = 35

func handleInput():
	var moveDirection = Input.get_vector("WalkLeft","WalkRight","WalkUp","WalkDown")
	velocity = moveDirection*speed

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
