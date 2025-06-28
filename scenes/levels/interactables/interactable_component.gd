extends IInteractable

class_name InteractableComponent

@export var interactable: Node3D
@export var mesh_instance: MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _interact(interactor: Node3D):
	super._interact(interactor)
	interactable.queue_free()

func _highlight_interactable():
	super._highlight_interactable()
	
func _unhighlight_interactable():
	super._unhighlight_interactable()
