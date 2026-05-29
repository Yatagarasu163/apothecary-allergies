extends Control
@onready var volume: HSlider = $VBoxContainer/Volume
@export var bus_name : String

var bus_index : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	bus_index = AudioServer.get_bus_index(bus_name)
	volume.value_changed.connect(_on_volume_value_changed)
	volume.value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		self.visible = true
		get_tree().paused = true


func _on_resume_pressed() -> void:
	self.visible = false
	get_tree().paused = false


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
