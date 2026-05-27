extends Area2D
@onready var chat_bubble: Node2D = $"../ChatBubble"
@onready var label: Label = $"../Label"
@onready var patient: Node2D = $".."
var interactable : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if interactable == true && Input.is_action_just_pressed("Interact"): 
			print("Player took customer's order")
			label.visible = false
			chat_bubble.visible = true

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		label.visible = true
		interactable = true
		label.text = "Press F to take order"
	if(body.name == "Patient"):
		patient.speed = 0
