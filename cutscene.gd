extends Control

@export var b1: Button
@export var b2: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	b1.pressed.connect(Globals.go_to_next)
	b2.pressed.connect(Globals.go_to_next)
	$Label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property($Label, "visible_characters", len($Label.text), len($Label.text) * 0.05)
	await tween.finished
	await get_tree().create_timer(1).timeout
	b1.visible = true
	await get_tree().create_timer(1).timeout
	b2.visible = true
