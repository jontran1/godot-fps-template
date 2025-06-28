extends Node

class_name AIMovementComponent

@export var SPEED: float = 1.0
@export var CHASE_SPEED: float = 2.0
@export var actor: Node3D
@export var nav_agent: NavigationAgent3D

var navigation_location: Vector3
var speed = SPEED

func _ready() -> void:
	navigation_location = actor.global_transform.origin

func _process(delta: float) -> void:
	if nav_agent == null:
		return
	actor.velocity = Vector3.ZERO
	nav_agent.set_target_position(navigation_location)
	var next_nav_point = nav_agent.get_next_path_position()		
	actor.velocity = (next_nav_point - actor.global_transform.origin).normalized() * speed 
	actor.rotation.y = lerp_angle(actor.rotation.y, atan2(-actor.velocity.x, -actor.velocity.z), delta * 10.0)
	actor.move_and_slide()

func move_to_location(location: Vector3) -> void:
	speed = SPEED
	navigation_location = location
	
func run_to_location(location: Vector3) -> void:
	speed = CHASE_SPEED
	navigation_location = location
