extends CanvasLayer

@onready var icon: TextureButton = $NotebookIcon
@onready var panel: Control = $NotebookIcon/NotebookPanel
@onready var left_text: TextEdit = $NotebookIcon/NotebookPanel/LeftPage/LeftTextEdit
@onready var right_label: RichTextLabel = $NotebookIcon/NotebookPanel/RightPage/RightRichLabel

var is_open: bool = false

func _ready() -> void:
	left_text.add_theme_color_override("font_color", Color(0.1, 0.1, 0.1)) # dark ink
	left_text.add_theme_color_override("font_selected_color", Color(1, 1, 1))
	left_text.add_theme_color_override("font_placeholder_color", Color(0.5, 0.5, 0.5, 0.6))
	
	var handwriting_font := load("res://assets/fonts/ks_hand.ttf")
	left_text.add_theme_font_override("font", handwriting_font)
	left_text.add_theme_font_size_override("font_size", 22)
	
	panel.visible = false
	icon.pressed.connect(_on_icon_pressed)

	# close button
	if panel.has_node("CloseButton"):
		panel.get_node("CloseButton").pressed.connect(close_notebook)

	_load_notes() # load saved player notes 

func _on_icon_pressed() -> void:
	if is_open:
		close_notebook()
	else:
		open_notebook()

func open_notebook() -> void:
	panel.visible = true
	panel.modulate.a = 0.0
	panel.scale = Vector2(0.8, 0.8)
	var tween := create_tween().set_parallel(true)
	tween.tween_property(panel, "modulate:a", 1.0, 0.15)
	tween.tween_property(panel, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BACK)
	is_open = true
	left_text.grab_focus()

func close_notebook() -> void:
	panel.visible = false
	is_open = false
	_save_notes()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_notebook"):
		_on_icon_pressed()
	if is_open and event.is_action_pressed("ui_cancel"):
		close_notebook()
		# these above are for the "n" keyboard shortcut to open/close the notebook
		# the ui_cancel is a built-in inputmap 
		
		
		
const SAVE_PATH := "user://player_notes.json"

func _save_notes() -> void:
	var data := {
		"player_text": left_text.text,
		"case_notes": right_label.text
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func _load_notes() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if parsed:
		left_text.text = parsed.get("player_text", "")
		right_label.text = parsed.get("case_notes", "")
		
		
		

signal note_added(text: String)

func add_auto_note(text: String, category: String = "") -> void:
	var timestamp := Time.get_time_string_from_system()
	var formatted := ""
	if category != "":
		formatted = "[b][%s][/b] %s\n" % [category, text]
	else:
		formatted = "%s\n" % text

	right_label.append_text(formatted)
	note_added.emit(text)

	if not is_open:
		_flash_icon_notification()

func _flash_icon_notification() -> void:
	if icon.has_node("NotificationDot"):
		icon.get_node("NotificationDot").visible = true # notification dot to notify player of updates to notebook
		

"""
now if we want to add anything to the notebook automatically, 
all we have to do is: 
Notebook.add_auto_note("Witness claims xxx", "Testimony")
"""
