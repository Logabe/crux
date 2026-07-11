extends Node

var i = 0 # Internal counter
var sequence_index: int = 0 

# Add the evidence scenes to this and they'll show up in game
var evidence_scenes: Array[String] = [
	"res://scenes/scene_2.tscn", 
	"res://scenes/scene_3.tscn", 
	"scene_4.tscn"
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
