extends Control

func _ready() -> void:
	$Label.text = "Scene " + str(Globals.scene_display_number()) + "/" + str(len(Globals.evidence_scenes))
	$AnimationPlayer.play("intro")
	ClickTracker.reset()
	next_arrow.visible = false
	progress_label.text = "0/%d" % required_clicks
	ClickTracker.first_click_registered.connect(_on_first_click_registered)

func next():
	$AnimationPlayer.play("outro")
	await $AnimationPlayer.animation_finished
	Globals.go_to_next()


@export var required_clicks: int = 2
@onready var progress_label: Label = $ProgressLabel
@onready var next_arrow: TextureButton = $TransitionButton


func _on_first_click_registered(object_name: String, total_count: int) -> void:
	progress_label.text = "%d/%d" % [total_count, required_clicks]

	if total_count >= required_clicks:
		next_arrow.visible = true
		


func _on_transition_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
