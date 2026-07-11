extends Control

func _ready() -> void:
	$Label.text = "Scene " + str(Globals.scene_display_number()) + "/" + str(len(Globals.evidence_scenes))
	$AnimationPlayer.play("intro")
func next():
	Globals.go_to_next()
