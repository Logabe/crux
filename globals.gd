extends Node

# TO USE THIS GLOBAL JUST 
# AFTER EVERY SCENE USE
# Globals.return_to_original() 
# TO GO BACK TO THE TEST SCENE AND MAKE THE PLAYER MAKE THE CHOICE AGAIN
# !!!!1

var i = 0 # Internal counter
var sequence_index: int = 0 

var guilty_votes: int = 0 
var innocent_votes: int = 0 


func register_vote(is_guilty: bool): 
	if is_guilty: 
		guilty_votes += 1
		print("Guilty votes: ", guilty_votes)
	else: 
		innocent_votes += 1
		print("Innocent votes: ", innocent_votes)
		
func get_final_ending() -> String: 
	if guilty_votes > innocent_votes: 
		return "res://scenes/ending_guilty.tscn"
	elif innocent_votes > guilty_votes: 
		return "res://scenes/ending_innocent.tscn"
	else: # if there's a tie we just randomly pick 1
		if randi() % 2 == 0: 
			return "res://scenes/ending_guilty.tscn"
		else: 
			return "res://scenes/ending_innocent.tscn"
	

# Add the evidence scenes to this and they'll show up in game
var evidence_scenes: Array[String] = [
	"res://scenes/scene_2.tscn", 
	"res://scenes/scene_3.tscn", 
	"res://scenes/scene_4.tscn"
]

const original_scene_path := "res://scenes/test.tscn"

func scene_number():
	return floor(i/2)
	
func scene_display_number():
	return scene_number() + 1

func go_to_next():
	if sequence_index < evidence_scenes.size():
		var next_scene: String = evidence_scenes[sequence_index]
		sequence_index += 1
		SceneTransition.goto_scene(next_scene)
	else:
		# all 4 evidence scenes done — go wherever the game goes after this loop
		SceneTransition.goto_scene("res://final_scene.tscn") # adjust to whatever comes next

func return_to_original(): 
	SceneTransition.goto_scene(original_scene_path)
