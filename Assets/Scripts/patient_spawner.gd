extends Node2D
@onready var timer: Timer = $Timer
@export var patient_prefab : PackedScene
@export var maximum_amount_of_patient = 5
var amount_of_patient_in_scene = 0


func _on_timer_timeout() -> void:
	var patient = patient_prefab.instantiate()
	if(amount_of_patient_in_scene < maximum_amount_of_patient):
		timer.start()
		print("Time out patient spawn")
		add_child(patient)
		amount_of_patient_in_scene += 1
	elif(amount_of_patient_in_scene == maximum_amount_of_patient):
		timer.stop()
