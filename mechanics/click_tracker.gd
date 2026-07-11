extends Node

"""
HOW TO USE 
func _on_pressed() -> void:
	ClickTracker.register_click(object_id)
	

Set object_id to "phone", "stereo", etc. in the Inspector for each button. 
This makes the system scale to any number of objects without writing new code every time.

"""

signal first_click_registered(object_name: String, total_count: int)

var clicked_objects: Dictionary = {} # e.g. { "phone": true, "stereo": true }
var first_click_count: int = 0

func register_click(object_id: String) -> void:
	if clicked_objects.has(object_id):
		return # already clicked before, ignore for counting purposes

	clicked_objects[object_id] = true
	first_click_count += 1
	first_click_registered.emit(object_id, first_click_count)
	print("First click on '%s' — total unique clicks: %d" % [object_id, first_click_count])

func reset() -> void:
	clicked_objects.clear()
	first_click_count = 0
