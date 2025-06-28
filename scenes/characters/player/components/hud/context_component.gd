extends CenterContainer

class_name ContextComponent

@export var icon: TextureRect
@export var context: Label
@export var default_icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.ui_context = self
	reset()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset() -> void:
	icon.texture = null
	context.text = ""
	
func update_icon(image: Texture2D, override: bool) -> void:
	if override:
		icon.texture = image
	else:
		icon.texture = default_icon
		
func update_content(text: String = "") -> void:
	context.text = text
