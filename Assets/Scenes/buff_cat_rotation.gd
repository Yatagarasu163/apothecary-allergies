extends AnimatedSprite2D

@export var clockwise: bool = false;
@export var rotation_speed: float = 5;

func _physics_process(delta: float) -> void:
	if clockwise:
		rotation_degrees = rotation_degrees + (1 * delta * rotation_speed);
	else:
		rotation_degrees = rotation_degrees + (-1 * delta * rotation_speed);
