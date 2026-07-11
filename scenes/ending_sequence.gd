extends Control

@onready var display_rect: TextureRect = $DisplayRect # add this node in the scene

var innocent_images: Array[Texture2D] = [
	preload("res://assets/art/InnocentPaper1.png"),
	preload("res://assets/art/InnocentPaper2.png"),
	preload("res://assets/art/InnocentPaper3.png"),
	preload("res://assets/art/InnocentPaper4.png"),
	preload("res://assets/art/didyoumaketherightchoice.png")
]
var guilty_images: Array[Texture2D] = [
	preload("res://assets/art/GuiltyPaper1.png"),
	preload("res://assets/art/GuiltyPaper2.png"),
	preload("res://assets/art/GuiltyPaper3.png"),
	preload("res://assets/art/GuiltyPaper4.png"),
	preload("res://assets/art/GuiltyPaper5.png"),
	preload("res://assets/art/didyoumaketherightchoice.png")
]

@export var fade_duration: float = 1.0
@export var hold_duration: float = 2.0

func _ready() -> void:
	print("Final tally — Guilty: ", Globals.guilty_votes, " Innocent: ", Globals.innocent_votes)
	display_rect.modulate.a = 0.0

	var images_to_play: Array[Texture2D]
	if Globals.innocent_votes > Globals.guilty_votes:
		images_to_play = innocent_images
	elif Globals.guilty_votes > Globals.innocent_votes:
		images_to_play = guilty_images
	else:
		# tie — random choice
		images_to_play = innocent_images if randi() % 2 == 0 else guilty_images

	await _play_cutscene(images_to_play)

	# after the whole sequence finishes, go wherever the game ends
	Globals.reset_game()
	ClickTracker.reset()
	Notebook.reset_notes()
	
	SceneTransition.goto_scene("res://scenes/main_menu.tscn") # adjust to your actual end point

func _play_cutscene(images: Array[Texture2D]) -> void:
	for img in images:
		display_rect.texture = img

		# fade in
		var fade_in := create_tween()
		fade_in.tween_property(display_rect, "modulate:a", 1.0, fade_duration)
		await fade_in.finished

		# hold on screen
		await get_tree().create_timer(hold_duration).timeout

		# fade out to black before next image
		var fade_out := create_tween()
		fade_out.tween_property(display_rect, "modulate:a", 0.0, fade_duration)
		await fade_out.finished



#extends Node2D
#
#@onready var innocent_images = [
	#load("res://assets/art/InnocentPaper1.png"),
	#load("res://assets/art/InnocentPaper2.png"),
	#load("res://assets/art/InnocentPaper3.png"),
	#load("res://assets/art/InnocentPaper4.png"),
#]
#
#@onready var guilty_images = [
	#load("res://assets/art/GuiltyPaper1.png"),
	#load("res://assets/art/GuiltyPaper2.png"),
	#load("res://assets/art/GuiltyPaper3.png"),
	#load("res://assets/art/GuiltyPaper4.png"),
	#load("res://assets/art/GuiltyPaper5.png"),
#]
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	## Innocent
	#if(Globals.verdict >= 0):
		#pass
	## Guilty
	#else:
		#pass
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
