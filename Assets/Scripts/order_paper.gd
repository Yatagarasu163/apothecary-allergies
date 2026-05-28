extends Control

func _process(_delta: float) -> void:
	if (GameManager.current_sickness.size() > 0):
		visible = true;
		
