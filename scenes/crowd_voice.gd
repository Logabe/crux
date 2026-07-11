extends TextureButton

@export var object_id: String = "crowdvoice"
@export var zoom_texture: Texture2D

func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)

func _on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		ClickTracker.register_click(object_id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_pressed() -> void:
	#$BoomSfx.play()
