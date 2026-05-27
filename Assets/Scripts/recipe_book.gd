extends Node2D

var is_player_inside: bool = false;

@onready var recipeUI = $RecipeBookUI;

func _ready() -> void:
	recipeUI.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_inside && Input.is_action_just_pressed("Add"):
		recipeUI.global_position = Vector2(0, 0);
		recipeUI.visible = !recipeUI.visible;
		print("Showing the recipe!");
		
	

func body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;
