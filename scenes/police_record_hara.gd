extends TextureButton

@export var object_id: String = "witnesstestimony"
@export var zoom_texture: Texture2D

func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)

func _on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		ClickTracker.register_click(object_id)
		ZoomPopup.show_zoom(zoom_texture, self)
	else:
		ZoomPopup.hide_zoom()
