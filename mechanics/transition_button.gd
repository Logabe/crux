extends TextureButton

# TO USE THIS: WHENEVER A NEW PIECE OF EVIDENCE IS CLICKED, JUST CALL EvidenceTracker.add_evidence()
# btw this is an autoload so make sure to enable it on globals in your version

@export var next_scene_path: String = "res://scenes/test.tscn"
@export var progress_label_path: NodePath  # drag your Label node here in inspector

@onready var progress_label: Label = get_node(progress_label_path)

func _ready() -> void:
	EvidenceTracker.evidence_updated.connect(_on_evidence_updated)
	pressed.connect(_on_pressed)

	# Initialize state based on current progress when scene loads
	_update_button_state(EvidenceTracker.current_evidence, EvidenceTracker.total_evidence)

func _on_evidence_updated(current: int, total: int) -> void:
	_update_button_state(current, total)

func _update_button_state(current: int, total: int) -> void:
	var complete := current >= total
	disabled = not complete

	if complete:
		progress_label.visible = false
	else:
		progress_label.visible = true
		progress_label.text = "View all potential evidence to continue (%d/%d)" % [current, total]

func _on_pressed() -> void:
	if not disabled:
		get_tree().change_scene_to_file(next_scene_path)
