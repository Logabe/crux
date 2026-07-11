extends Control


func _on_overlayed_animation_finished() -> void:
	queue_free()
