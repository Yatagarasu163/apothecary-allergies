extends Area2D
@onready var camera_2d: Camera2D = $"../Camera2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("Player enter the serving area")
		camera_2d.position.y = 0
