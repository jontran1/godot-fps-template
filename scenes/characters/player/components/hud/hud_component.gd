extends CanvasLayer

class_name HUDComponent

@onready var context_component: ContextComponent = $"ContextComponent"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_update_ui_interactable_context(interactable: Node3D) -> void:
	if interactable != null:
		context_component.update_content("Interact")
		context_component.update_icon(null, false)
	else:
		context_component.update_content()
		context_component.update_icon(null, true)
