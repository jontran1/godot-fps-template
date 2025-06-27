class_name DebugUtils

static func draw_debug_box(position: Vector3, size: float = 0.1) -> MeshInstance3D:
	var box = MeshInstance3D.new()
	box.mesh = BoxMesh.new()
	box.scale = Vector3(size, size, size)
	box.transform.origin = position
	box.material_override = StandardMaterial3D.new()
	box.material_override.albedo_color = Color(1, 0, 0, 0.5) # semi-transparent red
	return box
