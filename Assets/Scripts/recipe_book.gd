extends Node2D

@export var recipePages: Array[Control]
@export var currentPage: int

@export var recipeUI: Node

var is_player_inside: bool = false;
var newPage: int

func _ready() -> void:
	recipeUI.visible = false;
	for page in recipePages:
		page.visible = false;
	recipePages[3].visible = true;
	currentPage = 3;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_inside && Input.is_action_just_pressed("Add"):
		GameManager.ui_mode = !GameManager.ui_mode;
		recipeUI.global_position = Vector2(0, 0);
		recipeUI.visible = !recipeUI.visible;
		print("Showing the recipe!");

func updatePage():
	recipePages[currentPage].visible = false
	recipePages[newPage].visible = true
	currentPage = newPage

func body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true;

func body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false;


func _on_next_page_pressed() -> void:
	if (currentPage + 1 > recipePages.size() - 1): return
	newPage = currentPage + 1
	updatePage()


func _on_prevous_page_pressed() -> void:
	if (currentPage - 1 < 0): return
	newPage = currentPage - 1
	updatePage()
