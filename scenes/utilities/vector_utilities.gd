class_name VectorUtilities

static func get_random_point_around_vector3(origin: Vector3, radius: float) -> Vector3:
	var angle = randf_range(0, TAU) # TAU is 2 * PI
	var distance = randf_range(0, radius)
	# Convert polar coordinates to x and z offsets
	var offset = Vector3(
		distance * cos(angle),
		0, # Keep it on the same Y level; adjust if 3D roaming is needed
		distance * sin(angle)
	)	
	return origin + offset
