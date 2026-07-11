extends CanvasLayer

@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	layer = 100 # on top of everything
	fade_rect.color = Color(0, 0, 0, 0) # start transparent
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # don't block clicks while invisible

func goto_scene(path: String, fade_duration: float = 0.6) -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP # block input during transition
	var tween_out := create_tween()
	tween_out.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	await tween_out.finished

	get_tree().change_scene_to_file(path)
	await get_tree().process_frame # let the new scene actually load in

	var tween_in := create_tween()
	tween_in.tween_property(fade_rect, "color:a", 0.0, fade_duration)
	await tween_in.finished
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
