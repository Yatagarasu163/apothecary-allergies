extends Node2D
@onready var timer: Timer = $Timer
@export var patient_prefab : PackedScene
@export var maximum_amount_of_patient = 1




func _on_timer_timeout() -> void:
	var patient = patient_prefab.instantiate()
	patient.global_position.y = 1500;
	if(GameManager.amount_of_patient_on_screen < maximum_amount_of_patient ):
		timer.start()
		print("Time out patient spawn")
		add_child(patient)
		GameManager.amount_of_patient_on_screen += 1
	elif(GameManager.amount_of_patient_on_screen == maximum_amount_of_patient):
		pass
