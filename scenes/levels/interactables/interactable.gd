extends Node3D

@onready var interactable_component: InteractableComponent = get_node("InteractableComponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _interact(interactor: Node3D) -> void:
	call_component_method("_interact", [interactor])

func _highlight_interactable() -> void:
	call_component_method("_highlight_interactable")

func _unhighlight_interactable() -> void:
	call_component_method("_unhighlight_interactable")
	
# DRY utility method in your base class or shared script
func call_component_method(method_name: String, args: Array = []) -> void:
	if interactable_component and method_name in interactable_component:
		interactable_component.callv(method_name, args)
	else:
		push_warning("Component missing or method `%s` not found on %s" % [method_name, name])
