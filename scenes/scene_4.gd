extends Control

@onready var vid_scene = preload("res://scenes/video_player.tscn")


func _on_button_pressed() -> void:
	add_child(vid_scene.instantiate())

@export var required_clicks: int = 1
@onready var progress_label: Label = $CCTV/ProgressLabel
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
		


func _on_transition_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
