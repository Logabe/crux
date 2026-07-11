extends TextureButton

@export var object_id: String = "crowdvoice"
@export var zoom_texture: Texture2D

func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)

func _on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		ClickTracker.register_click(object_id)
	var sfx = AudioStreamPlayer.new()
	add_child(sfx)
	sfx.stream = AudioGlobal.radio_click_sound
	sfx.play()
	await sfx.finished
	sfx.queue_free()
