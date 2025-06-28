extends Node

class_name AIController

const GROUP_TARGET_NAME = "Player"

@export var actor: Node3D
@export var ai_movement_component: AIMovementComponent
@export var perception_component: AIPerceptionComponent

@onready var CHARACTER_STATE = CharacterStates.CHARACTER_STATE
@onready var current_character_state = CHARACTER_STATE.SEARCHING
@onready var search_location_timer: Timer = $SearchLocationTimer

signal on_character_state_update(state: CharacterStates.CHARACTER_STATE)

var current_target: Node3D
var search_location: Vector3
var last_Search_location: Vector3
const ARRIVAL_THRESHOLD = 0.5 # adjust as needed

func _ready() -> void:
	search_location = actor.global_position
	search_location_timer.start()

func _process(delta: float) -> void:
	match current_character_state:
		CHARACTER_STATE.CHASING:
			on_character_state_update.emit(current_character_state)
			var target_location: Vector3 = current_target.global_transform.origin
			ai_movement_component.move_to_location(target_location)
		CHARACTER_STATE.SEARCHING:
			on_character_state_update.emit(current_character_state)
			ai_movement_component.run_to_location(search_location)
			var direction = search_location - actor.global_transform.origin

			if direction.length() < ARRIVAL_THRESHOLD and last_Search_location != search_location:
				last_Search_location = search_location
				search_location_timer.start()
			
func vision_detection_changed(node: Node3D) -> void:
	if node != null and node.is_in_group(GROUP_TARGET_NAME):
		current_character_state = CHARACTER_STATE.CHASING
		current_target = node
		search_location_timer.stop()
	else:
		current_character_state = CHARACTER_STATE.SEARCHING
		search_location = current_target.global_transform.origin
		search_location_timer.start()
		
func _on_search_location_timer_timeout() -> void:
	var radius: int = 10
	if current_target == null:
		search_location = VectorUtilities.get_random_point_around_vector3(actor.global_transform.origin, radius)
	current_target = null	
