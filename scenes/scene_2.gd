extends Node # or Control, attach to your Scene2 root or a dedicated "LevelManager" node

@export var required_clicks: int = 3
@onready var progress_label: Label = $ProgressLabel
@onready var next_arrow: TextureButton = $TransitionButton

func _ready() -> void:
	ClickTracker.reset()
	next_arrow.visible = false
	progress_label.text = "0/%d" % required_clicks
	ClickTracker.first_click_registered.connect(_on_first_click_registered)

func _on_first_click_registered(object_name: String, total_count: int) -> void:
	progress_label.text = "%d/%d" % [total_count, required_clicks]

	if total_count >= required_clicks:
		next_arrow.visible = true
