extends Node2D
@onready var cat_feed_count = $Label
@onready var button = $ScrollContainer/VBoxContainer/Button
@onready var button2 = $ScrollContainer/VBoxContainer/Button2
@onready var button3 = $ScrollContainer/VBoxContainer/Button3
@onready var button4 = $ScrollContainer/VBoxContainer/Button4
@onready var clicky = int(0)
@onready var additional_clicks = 0
@onready var animation = $AnimationPlayer
@onready var blobcat1_bought := false
@onready var blobcat2_bought := false
@onready var catfeed_animation = $cat_feed_animation
@onready var blobcat2_animation = $blobcat2_animation
var can_click := false
func _on_button_mouse_entered() -> void: #show price on hover
	button.text = 'COST: 10  feed'
func _on_button_mouse_exited() -> void:  #remove price after hover
	button.text = '+1 feed/click'
	
func _on_button_2_mouse_entered() -> void: 
	button2.text = 'COST: 99  feed'
func _on_button_2_mouse_exited() -> void:
	button2.text = '+10  feed/click'

func _on_button_3_mouse_entered() -> void:
	if not blobcat1_bought:
		button3.text = "COST: 40 0  feed"
	else:
		button3.text = "BOUGHT"
func _on_button_3_mouse_exited() -> void:
	button3.text = "Blob cat 1"

func _process(delta: float) -> void:
	cat_feed_count.text = "CAT FEED: " + str(clicky)
	if can_click:
		if Input.is_action_just_pressed("click"): 
			clicky += int(1) + int(additional_clicks)
			catfeed_animation.play("catfeed")
			click.play()



func _on_button_pressed() -> void: #button1 (purchase)
	if clicky >= 10:
		additional_clicks += 1
		clicky -= 10


func _on_button_2_pressed() -> void: #button2 (purchase)
	if clicky >= 99:
		additional_clicks += 10
		clicky -= 99


func _on_button_3_pressed() -> void: #blob cat (purchase)
	if clicky >= 400 and not blobcat1_bought:
		clicky -= 400
		animation.play("blobcat1_entry")
		random_meow()
		blobcat1_bought = true

func random_meow():
	var random_float = randf()
	randomize()
	if random_float <= 0.32:
		meow.play()
	if random_float >= 0.33 and random_float <= 0.66:
		meow1.play()
	if random_float >= 0.67:
		meow2.play()

func _on_area_2d_mouse_entered() -> void:
	can_click = true
func _on_area_2d_mouse_exited() -> void:
	can_click = false


func _on_meow_2d_mouse_entered() -> void:
	random_meow()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "blobcat1_entry":
		animation.play("blobcat1_move")
		print("blobcat1 entry finished - starting movement")


func _on_button_4_mouse_entered() -> void:
	if not blobcat2_bought:
			button4.text = "COST: 1999  feed"
	else:
		button4.text = "BOUGHT"
func _on_button_4_mouse_exited() -> void:
	button4.text = "Blob cat 2"
func _on_button_4_pressed() -> void:
	if clicky >= 1999 and not blobcat2_bought:
		clicky -= 1999
		blobcat2_animation.play("blobcat2_entry")
		random_meow()
		blobcat2_bought = true


func _on_blobcat_2_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "blobcat2_entry":
		blobcat2_animation.play("blobcat2_move")
		print("blobcat2 entry finished - starting movement")
