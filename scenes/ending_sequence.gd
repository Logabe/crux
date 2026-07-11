extends Node2D

@onready var innocent_images = [
	load("res://assets/art/InnocentPaper1.png"),
	load("res://assets/art/InnocentPaper2.png"),
	load("res://assets/art/InnocentPaper3.png"),
	load("res://assets/art/InnocentPaper4.png"),
]

@onready var guilty_images = [
	load("res://assets/art/GuiltyPaper1.png"),
	load("res://assets/art/GuiltyPaper2.png"),
	load("res://assets/art/GuiltyPaper3.png"),
	load("res://assets/art/GuiltyPaper4.png"),
	load("res://assets/art/GuiltyPaper5.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Innocent
	if(Globals.verdict >= 0):
		pass
	# Guilty
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
