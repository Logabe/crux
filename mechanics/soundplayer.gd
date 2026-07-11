extends TextureButton

@export var streams: Array[AudioStream]

@onready var player = $AudioStreamPlayer

var i: int = 0

var piptex  = preload("res://assets/art/AudioPlayerPip.png")
var piptexactivated = preload("res://assets/art/AudioPlayerPipActivate.png")

func _ready():
	var scene = preload("res://mechanics/audio_player_pip.tscn")
	for i in streams:
		$PipsContainer.add_child(scene.instantiate())

func interact(toggled: bool):
	if !player.playing and !player.stream_paused:
		player.stream = streams[0]
		player.play()
	player.stream_paused = !toggled
	$PipsContainer.get_child(0).texture = piptexactivated

func play_next() -> void:
	$PipsContainer.get_child(i).texture = piptex
	i = (i + 1) % len(streams)
	player.stream = streams[i]
	player.play()
	$PipsContainer.get_child(i).texture = piptexactivated
