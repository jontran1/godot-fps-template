extends Node

class_name AIPerceptionComponent

@onready var vision_area: Area3D = $VisionArea
@onready var vision_ray_cast: RayCast3D = $VisionArea/VisionRayCast

signal vision_detection_changed(node: Node3D)

var player: Node3D

func _on_vision_timer_timeout() -> void:
	var over_lapping_bodies = vision_area.get_overlapping_bodies()
	if over_lapping_bodies.size() > 0:
		for body in over_lapping_bodies:
			if is_type_detected(body, "Player"):
				player = body
				vision_detection_changed.emit(body)
				return
			
	if player != null:
		player = null
		vision_detection_changed.emit(null)
	
func is_type_detected(body: Node3D, group_name: String) -> bool:
	if body.is_in_group(group_name):
		var player = body
		vision_ray_cast.look_at(player.global_position)
		vision_ray_cast.force_raycast_update()
		if vision_ray_cast.is_colliding():
			return true
	return false
