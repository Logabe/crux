extends Control

@export var b1: Button
@export var b2: Button
@onready var background_sprite: Sprite2D = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_sprite.visible = false 
	background_sprite.modulate.a = 0.0 # fully ransparent at the start
	b1.pressed.connect($AnimationPlayer.play.bind("fade"))
	b2.pressed.connect($AnimationPlayer.play.bind("fade"))
	$Label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property($Label, "visible_characters", len($Label.text), len($Label.text) * 0.05)
	await tween.finished
	await get_tree().create_timer(1).timeout
	b1.visible = true
	await get_tree().create_timer(1).timeout
	b2.visible = true
	await get_tree().create_timer(0.3).timeout
	
	background_sprite.visible = true
	var bg_tween = create_tween()
	bg_tween.tween_property(background_sprite, "modulate:a", 2.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	

#func go_to_next():
	#Globals.go_to_next()
