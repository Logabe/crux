extends Node

var i = 0 # Internal counter

# Add the evidence scenes to this and they'll show up in game
var evidence_scenes = ["evidence1.tscn"]

func scene_number():
	return floor(i/2)
	
func scene_display_number():
	return scene_number() + 1

func go_to_next():
	print("hi")
	i = (1 + i) % (len(evidence_scenes) * 2)
	var path = "test.tscn" if i % 2 == 0 else evidence_scenes[scene_number()]
	get_tree().change_scene_to_file("scenes/" + path)
