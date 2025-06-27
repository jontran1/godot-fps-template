extends Node3D

# bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

# fov variables
@export var BASE_FOV = 75.0
@export var FOV_CHANGE = 1.5
@export var SENSITIVITY = 0.004
@export var actor: Player
@export var movement_component: MovementComponent
@onready var camera: Camera3D = get_node("Camera3D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Head bob
	t_bob += delta * actor.velocity.length() * float(actor.is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(actor.velocity.length(), 0.5, movement_component.sprint_speed * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _on_input_component_input_mouse_moved(mouse_event: InputEventMouseMotion) -> void:
	rotate_y(-mouse_event.relative.x * SENSITIVITY)
	camera.rotate_x(-mouse_event.relative.y * SENSITIVITY)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(70))
