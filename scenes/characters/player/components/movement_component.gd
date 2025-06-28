extends Node

class_name MovementComponent

# Required assignments
@export var actor: CharacterBody3D
@export var look_pivot: Node3D

# movement variables
@export var walk_speed: float = 5.0
@export var jump_velocity: float = 3.0
@export var sprint_speed: float = 7.0
@export var gravity: float = 9.8

var speed = walk_speed
var direction: Vector3

func _ready() -> void:
	speed = walk_speed
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not actor.is_on_floor():
		actor.velocity.y -= gravity * delta
		
	# Handle the movement/deceleration.
	actor.velocity.x = lerp(actor.velocity.x, direction.x * speed, delta * acceleration_factor())
	actor.velocity.z = lerp(actor.velocity.z, direction.z * speed, delta * acceleration_factor())

	actor.move_and_slide()
	
func acceleration_factor() -> float:
	if actor.is_on_floor():
		if direction:
			return 15.0
		return 7.0
	else:
		return 3.0
		
func _on_jump() -> void:
	if actor.is_on_floor():
		actor.velocity.y = jump_velocity

func _on_sprint() -> void:
	speed = sprint_speed

func _on_stop_sprint() -> void:
	speed = walk_speed
	
func _on_input_component_input_direction_moved(input_direction: Vector2) -> void:
	direction = (look_pivot.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

func _move_toward_target(target_global_position: Vector3) -> void:
	var to_target = target_global_position - actor.global_transform.origin
	var input_direction = Vector2(to_target.x, to_target.z).normalized()
	_on_input_component_input_direction_moved(Vector2(input_direction.x, input_direction.y))
