extends TextureButton

@export var object_id: String = "crowdvoice"
@export var zoom_texture: Texture2D

@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var transcript_label: Label = $TranscriptLabel

@export var audio_clips: Array[AudioStream] = []
@export var transcripts: Array[String] = []

var current_index: int = 0 


func _ready() -> void:
	toggle_mode = true
	toggled.connect(_on_toggled)
	transcript_label.visible = false 
	audio_player.finished.connect(_on_audio_finished)

func _on_toggled(is_pressed: bool) -> void:
	if is_pressed:
		ClickTracker.register_click(object_id)
	var clip := audio_clips[current_index]
	audio_player.stream = clip 
	audio_player.play() 
	
	transcript_label.text = transcripts[current_index]
	transcript_label.visible = true 
	
	disabled = true 
	
	current_index = (current_index + 1) % audio_clips.size()
	
func _on_audio_finished() -> void: 
	transcript_label.visible = false
	disabled = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_pressed() -> void:
	#$BoomSfx.play()
	var sfx = AudioStreamPlayer.new()
	add_child(sfx)
	sfx.stream = AudioGlobal.radio_click_sound
	sfx.play()
	await sfx.finished
	sfx.queue_free()
