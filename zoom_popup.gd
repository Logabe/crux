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

	var max_size := Vector2(800, 1200)
	var tex_size := texture.get_size()
	var scale_factor: float = min(max_size.x / tex_size.x, max_size.y / tex_size.y, 1.0)
	zoomed_texture.custom_minimum_size = tex_size * scale_factor
	zoomed_texture.size = tex_size * scale_factor

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
