extends Node2D

@export var recipePages: Array[Control]
@export var currentPage: int
var isReading: bool

@export var recipeUI: Node

var is_player_inside: bool = false;
var newPage: int

func _ready() -> void:
	recipeUI.visible = false;
	for page in recipePages:
		page.visible = false;
	recipePages[4].visible = true;
	currentPage = 4;
	z_index = position.y
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Add"):
		_on_prevous_page_pressed()
	if Input.is_action_just_pressed("Interact"):
		_on_next_page_pressed()
	
	if is_player_inside && Input.is_action_just_pressed("Add") and not isReading:
		for page in recipePages:
			page.visible = false;
		recipePages[4].visible = true;
		currentPage = 4;
		recipeUI.global_position = Vector2(0, 0);
		recipeUI.visible = !recipeUI.visible;
	if is_player_inside == false:
		recipeUI.visible = false;

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
