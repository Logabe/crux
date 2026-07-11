extends CanvasLayer

@onready var dim_bg: ColorRect = $DimBackground
@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var zoomed_texture: TextureRect = $ScrollContainer/ZoomedTextureRect


var current_source_button: BaseButton = null


func _ready() -> void:
	visible = false
	dim_bg.gui_input.connect(_on_background_input)

func show_zoom(texture: Texture2D, source_button: BaseButton = null) -> void:
	current_source_button = source_button
	zoomed_texture.texture = texture


	visible = true
	scroll_container.scroll_vertical = 0 # reset scroll position each time it opens
	scroll_container.modulate.a = 0.0
	var tween := create_tween()
	tween.tween_property(scroll_container, "modulate:a", 1.0, 0.15)

func hide_zoom() -> void:
	visible = false
	# sync the button back to unpressed if it wasn't already
	if current_source_button and current_source_button.button_pressed:
		current_source_button.set_pressed_no_signal(false)
	current_source_button = null


func _on_background_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		hide_zoom()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		hide_zoom()
