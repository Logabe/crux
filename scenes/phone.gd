extends TextureButton

@export var object_id: String = "phone"
@export var zoom_texture: Texture2D

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)

func _on_toggled(is_pressed: bool) -> void:
	# 20% chance to trigger
	if is_pressed and (rng.randi_range(0, 5) == 1):
		var video_node = VideoStreamPlayer.new()
		video_node.stream = load("res://assets/ontik/fun_video.ogv")
		add_child(video_node)
		video_node.play()
		await video_node.finished
		video_node.queue_free()
	elif is_pressed:
		ClickTracker.register_click(object_id)
		ZoomPopup.show_zoom(zoom_texture, self)
	else:
		ZoomPopup.hide_zoom()
