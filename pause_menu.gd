extends Control

# NOTE: WHENEVER YOU WANT TO ADD THE PAUSE MENU TO A SCENE, ADD IT AS A CHILD OF A CANVASLAYER FIRST 
# because that way the pause menu will be drawn over everything else 

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.play("RESET")
	visible = false

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur") # if the animationplayer's name is changed (rn the animation is called "blur") then this needs to be changed too

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()


func _on_options_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()
	
	Globals.reset_game()
	ClickTracker.reset()
	Notebook.reset_notes()
	
	SceneTransition.goto_scene("res://scenes/main_menu.tscn")
