extends Node

class_name IInteractable

@onready var interactable_mesh: MeshInstance3D = self.mesh_instance

func _interact(interactor: Node3D):
	print("IInteractable: interacted")

func _highlight_interactable():
	interactable_mesh.material_overlay = load("res://scenes/levels/interactables/interactable_highlight.tres")
	
func _unhighlight_interactable():
	interactable_mesh.material_overlay = null
