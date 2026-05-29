extends Node2D

@onready var test = $CanvasLayer/Pestle/Add;

func _pestle_add_pressed() -> void:
	print("I am pressed!");
