extends Control

@export var b1: Button # innocent 
@export var b2: Button # guilty 
@onready var background_sprite: Sprite2D = $Background
@onready var dna_report: TextureButton = $DNAReport
@onready var hospital_report: TextureButton = $HospitalReport
@onready var witness_testimony: TextureButton = $WitnessTestimony



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_sprite.visible = false 
	dna_report.visible = false
	hospital_report.visible = false 
	witness_testimony.visible = false 
	background_sprite.modulate.a = 0.0 # fully ransparent at the start
	#b1.pressed.connect($AnimationPlayer.play.bind("fade"))
	#b2.pressed.connect($AnimationPlayer.play.bind("fade"))
	b1.pressed.connect(_on_choice_made)
	b2.pressed.connect(_on_choice_made)
	$Label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property($Label, "visible_characters", len($Label.text), len($Label.text) * 0.05)
	await tween.finished
	await get_tree().create_timer(1).timeout
	b1.visible = true
	await get_tree().create_timer(1).timeout
	b2.visible = true
	await get_tree().create_timer(0.3).timeout
	
	background_sprite.visible = true
	var bg_tween = create_tween()
	bg_tween.tween_property(background_sprite, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.2).timeout
	
	dna_report.visible = true 
	var dna_report_tween = create_tween()
	dna_report_tween.tween_property(dna_report, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	hospital_report.visible = true 
	var hospital_report_tween = create_tween()
	hospital_report_tween.tween_property(hospital_report, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
	witness_testimony.visible = true 
	var witness_testimony_tween = create_tween()
	witness_testimony_tween.tween_property(witness_testimony, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_guilty_pressed(): 
	Globals.register_vote(true)
	_on_choice_made() 
	
func _on_innocent_pressed(): 
	Globals.register_vote(false)
	_on_choice_made()

func _on_choice_made() -> void:
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	
	if Globals.sequence_index >= Globals.evidence_scenes.size(): 
		var ending_path := Globals.get_final_ending()
		SceneTransition.goto_scene(ending_path)
	else: 
		Globals.go_to_next()
#func go_to_next():
	#Globals.go_to_next()
