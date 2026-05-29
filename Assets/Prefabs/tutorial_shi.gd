extends Control

@onready var next_button = $Next;
@onready var back_button = $back;
@onready var start_button = $Start;
@onready var letter_label = $Label;
@onready var instruction_label = $Label2;
@onready var next_anim = $Next/AnimatedSprite2D;
@onready var back_anim = $back/AnimatedSprite2D;
@onready var start_anim = $Start/AnimatedSprite2D;
@onready var canvas_layer = $"..";
@onready var ui_layer = $"../../Book";

func _ready() -> void:
	back_button.visible = false;
	start_button.visible = false;
	letter_label.visible = true;
	instruction_label.visible = false;

func _on_next_pressed() -> void:
	next_anim.play("pressed");
	if letter_label.visible:
		letter_label.visible = false;
		instruction_label.visible = true;
		next_button.visible = false;
		back_button.visible = true;
		start_button.visible = true;

func _on_next_mouse_entered() -> void:
	next_anim.play("hover");


func _on_next_mouse_exited() -> void:
	next_anim.play("idle");

func _on_back_mouse_entered() -> void:
	back_anim.play("hover");

func _on_back_pressed() -> void:
	back_anim.play("pressed");
	if instruction_label.visible:
		instruction_label.visible = false;
		letter_label.visible = true;
		back_button.visible = false;
		next_button.visible = true;
		start_button.visible = false;

func _on_back_mouse_exited() -> void:
	back_anim.play("idle");


func _on_start_pressed() -> void:
	start_anim.play("pressed");
	start_button.visible = false;
	ui_layer.visible = true;
	canvas_layer.visible = false;
