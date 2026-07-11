extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


@export var object_id: String = "cctv"


func _on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		ClickTracker.register_click(object_id)
