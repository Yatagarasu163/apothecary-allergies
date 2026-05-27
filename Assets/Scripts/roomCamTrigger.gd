extends Area2D
class_name AreaDetect

@export var roomCamPosition: Vector2
@export var camera_2d: CameraControl


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("Player enter the serving area")
		camera_2d.setNewPosition(roomCamPosition)
