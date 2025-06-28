extends RayCast3D

@export var interact_distance: float = 3
@export var player_camera: Camera3D
@export var interactor: Player
var raycast_timer := Timer.new()
var highlighted_interactable: Node3D = null
signal interactable_hover_updated(interactable: Node3D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_interact_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_interaction_status():
	var result = interact_cast()
	if result:
		interactable_hover_updated.emit(result)
	else:
		interactable_hover_updated.emit(null)

func interact() -> void:
	var raycast_result: Node3D = interact_cast()
	if raycast_result \
		and raycast_result.is_in_group("InteractableObject") \
		and raycast_result.has_method("_interact"):
		raycast_result._interact(interactor)

func interact_cast() -> Node3D:
	var raycast_result: Node3D = null
	var space_state = player_camera.get_world_3d().direct_space_state
	var screen_center = get_viewport().size / 2
	var origin = player_camera.project_ray_origin(screen_center)
	var end = origin + player_camera.project_ray_normal(screen_center) * interact_distance
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	var current_cast_result = result.get("collider")
	if current_cast_result \
		and current_cast_result.is_in_group("InteractableObject"):
		raycast_result = current_cast_result
		if raycast_result.has_method("_highlight_interactable"):
			raycast_result._highlight_interactable()
			highlighted_interactable = raycast_result
	else:
		raycast_result = null
	if highlighted_interactable != null and raycast_result != highlighted_interactable:
		if highlighted_interactable.has_method("_unhighlight_interactable"):
			highlighted_interactable._unhighlight_interactable()
		highlighted_interactable = null
	return raycast_result

func set_interact_timer() -> void:
	raycast_timer = Timer.new()
	raycast_timer.wait_time = .1
	raycast_timer.autostart = true
	raycast_timer.timeout.connect(update_interaction_status)
	add_child(raycast_timer)
