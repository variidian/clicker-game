extends Node2D
@onready var animation = $AnimationPlayer
func _ready():
	animation.play("logo")
func _on_button_pressed() -> void: #start game button
	click.play()
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_area_2d_mouse_entered() -> void: #cat meow when hovering!
	var random_float = randf()
	randomize()
	if random_float <= 0.32:
		meow.play()
	if random_float >= 0.33 and random_float <= 0.66:
		meow1.play()
	if random_float >= 0.67:
		meow2.play()
