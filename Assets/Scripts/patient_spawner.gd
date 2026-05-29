extends Node2D
@onready var timer: Timer = $Timer
@export var patient_prefab : PackedScene
var current_day = GameManager.day;


func _ready() -> void:
	if(GameManager.day <= 3):
		GameManager.maximum_amount_of_patient = randi_range(3, 5)

func _process(_delta: float) -> void:
	if GameManager.day != current_day:
		print("Current day: ", current_day)
		print("GameManager day: ", GameManager.day)
		current_day = GameManager.day;
		start_next_day();

func start_next_day() -> void:
	if(GameManager.day <= 3):
		GameManager.maximum_amount_of_patient = randi_range(3, 5);
		GameManager.amount_of_patient_spawn = 0;
	print("Max amnt of patient: ",GameManager.maximum_amount_of_patient)
	print("Amnt of patient spawn: ",GameManager.amount_of_patient_spawn)
	timer.start()


func _on_timer_timeout() -> void:
	var patient = patient_prefab.instantiate()
	patient.global_position.y = 1500;
	if(GameManager.amount_of_patient_spawn < GameManager.maximum_amount_of_patient ):
		timer.start()
		print("Time out patient spawn")
		print("Maximum amount of patient for today",GameManager.maximum_amount_of_patient)
		print("amount of patient spawn",GameManager.amount_of_patient_spawn)
		add_child(patient)
		GameManager.amount_of_patient_on_screen += 1
		GameManager.amount_of_patient_spawn += 1
	elif(GameManager.amount_of_patient_spawn == GameManager.maximum_amount_of_patient):
		timer.stop()
