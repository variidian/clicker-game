extends Node2D
@onready var cat_feed_count = $Label
@onready var button = $ScrollContainer/VBoxContainer/Button
@onready var button2 = $ScrollContainer/VBoxContainer/Button2
@onready var button3 = $ScrollContainer/VBoxContainer/Button3
@onready var clicky = int(0)
@onready var additional_clicks = 0
@onready var animation = $AnimationPlayer
var can_click := false
func _on_button_mouse_entered() -> void: #show price on hover
	button.text = 'COST: 10  feed'
	can_click = false
func _on_button_mouse_exited() -> void:  #remove price after hover
	button.text = '+1 feed/click'
	
func _on_button_2_mouse_entered() -> void: 
	button2.text = 'COST: 99  feed'
	can_click = false
func _on_button_2_mouse_exited() -> void:
	button2.text = '+10  feed/click'

func _on_button_3_mouse_entered() -> void:
	button3.text = "COST: 333 feed"
	can_click = false
func _on_button_3_mouse_exited() -> void:
	button3.text = "Blob cat 1"

func _process(delta: float) -> void:
	cat_feed_count.text = "CAT FEED: " + str(clicky)
	if can_click:
		if Input.is_action_just_pressed("click"):
			clicky += int(1) + int(additional_clicks)



func _on_button_pressed() -> void: #button1 (purchase)
	if clicky >= 10:
		additional_clicks += 1
		clicky -= 10


func _on_button_2_pressed() -> void: #button2 (purchase)
	if clicky >= 99:
		additional_clicks += 10
		clicky -= 99


func _on_button_3_pressed() -> void: #blob cat (purchase)
	if clicky >= 333:
		clicky -= 333
		animation.play("blobcat1_entry")



func _on_area_2d_mouse_entered() -> void:
	can_click = true
func _on_area_2d_mouse_exited() -> void:
	can_click = false
