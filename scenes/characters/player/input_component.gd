extends Node

class_name InputComponent

signal input_direction_moved(input_direction: Vector2)
signal input_mouse_moved(mouse_event: InputEventMouseMotion)
signal input_jumped_pressed()
signal input_sprint_pressed()
signal input_sprint_released()
signal input_interact_pressed()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction_moved.emit(input_direction)	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		input_mouse_moved.emit(event)
	if Input.is_action_just_pressed("jump"):
		input_jumped_pressed.emit()
	elif Input.is_action_just_pressed("sprint"):
		input_sprint_pressed.emit()
	elif Input.is_action_just_released("sprint"):
		input_sprint_released.emit()
	elif Input.is_action_just_released("interact"):
		input_interact_pressed.emit()
	elif Input.is_key_pressed(KEY_ESCAPE): #TODO remove later
		get_tree().quit()
