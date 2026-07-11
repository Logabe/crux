extends Control

@onready var vid_scene = preload("res://scenes/video_player.tscn")


func _on_button_pressed() -> void:
	add_child(vid_scene.instantiate())
