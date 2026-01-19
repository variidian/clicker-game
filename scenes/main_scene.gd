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
@onready var autoclick = $ScrollContainer/VBoxContainer/autoclick_purchase
@onready var autoclick_timer = $autoclick_timer
@onready var autoclicker = 0
@onready var feeding_text = $Label2
@onready var can_click := false
@onready var tutorial = $tutorial
@onready var in_frenzy := false
@onready var frenzy_anim = $frenzy_animation
@onready var frenzy_multiplier = 1
@onready var frenzy_sprite = $frenzy
@onready var frenzy_sprite2 = $frenzy1
@onready var frenzy_timer = $frenzy_timer
@onready var frenzy_sound = $frenzy_sound
@onready var blobcat_amount = 0
@onready var started_feeding := false
@onready var feeding_blobcat_timer = $feeding_blobcat
@onready var munch_sound = $munch
@onready var eating_label = $eating_label
@onready var eating_animation = $eating
@onready var game_end_animation = $game_end
@onready var game_end_text = $game_end_text
@onready var game_end_bg = $game_end_bg
@onready var game_ended := false
@onready var button5 = $ScrollContainer/VBoxContainer/Button5
@onready var blobcat3_bought := false
@onready var blobcat4_bought := false
@onready var blobcat5_bought := false
@onready var blobcat3_animation = $blobcat3
@onready var button6 = $ScrollContainer/VBoxContainer/Button6
@onready var blobcat4_animation = $blobcat4
@onready var button7 = $ScrollContainer/VBoxContainer/Button7

func _ready():
	feeding_text.hide()
	frenzy_sprite.hide()
	frenzy_sprite2.hide()
	eating_label.hide()
	game_end_bg.hide()
	game_end_text.hide()
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
		button3.text = "COST: 50 0 0  feed"
	else:
		button3.text = "BOUGHT"
func _on_button_3_mouse_exited() -> void:
	button3.text = "Blob cat 1"

func _process(delta: float) -> void:
	cat_feed_count.text = "CAT FEED: " + str(clicky)
	if can_click:
		if Input.is_action_just_pressed("click"): 
			clicky += (int(1) + int(additional_clicks)) * frenzy_multiplier
			catfeed_animation.play("catfeed")
			click.play()
			chance_for_frenzy()
	if blobcat_amount >= 1 and not started_feeding:
		started_feeding = true
		feeding_blobcat_timer.start()
	if not game_ended and clicky <= -10000:
		game_end_animation.play("game_end")
		game_end_bg.show()
		game_end_text.show()
		game_ended = true



func _on_button_pressed() -> void: #button1 (purchase)
	if clicky >= 10:
		additional_clicks += 1
		clicky -= 10


func _on_button_2_pressed() -> void: #button2 (purchase)
	if clicky >= 99:
		additional_clicks += 10
		clicky -= 99


func _on_button_3_pressed() -> void: #blob cat (purchase)
	if clicky >= 5000 and not blobcat1_bought:
		clicky -= 5000
		animation.play("blobcat1_entry")
		feeding_text.show()
		tutorial.play("blobcat_feeding")
		random_meow()
		blobcat1_bought = true
		blobcat_amount += 1

func random_meow():
	var random_float = randf()
	randomize()
	if random_float <= 0.32:
		meow.play()
	if random_float >= 0.33 and random_float <= 0.66:
		meow1.play()
	if random_float >= 0.67:
		meow2.play()
func chance_for_frenzy():
	var random_float = randf()
	randomize()
	if random_float <= 0.01:
		do_frenzy()
		in_frenzy = true
func do_frenzy():
	frenzy_anim.play("frenzy")
	frenzy_multiplier = 2
	frenzy_sprite.show()
	frenzy_sprite2.show()
	frenzy_timer.start()
	frenzy_sound.play()

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
			button4.text = "COST: 9999  feed"
	else:
		button4.text = "BOUGHT"
func _on_button_4_mouse_exited() -> void:
	button4.text = "Blob cat 2"
func _on_button_4_pressed() -> void:          #blobcat purchase
	if clicky >= 9999 and not blobcat2_bought:
		clicky -= 9999
		blobcat2_animation.play("blobcat2_entry")
		random_meow()
		blobcat2_bought = true
		blobcat_amount += 2


func _on_blobcat_2_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "blobcat2_entry":
		blobcat2_animation.play("blobcat2_move")
		print("blobcat2 entry finished - starting movement")


func _on_autoclick_purchase_pressed() -> void:
	if clicky >= 99:
		if autoclicker == 0:
			autoclick_timer.start()
		clicky -= 99
		autoclicker += 1

func _on_autoclick_purchase_mouse_entered() -> void:
	autoclick.text = "COST: 99  feed"
func _on_autoclick_purchase_mouse_exited() -> void:
	autoclick.text = "+1/sec auto click"

func _on_autoclick_timer_timeout() -> void:
	clicky += autoclicker
	click.play()

func _on_frenzy_timer_timeout() -> void:
	frenzy_multiplier = 1


func _on_feeding_blobcat_timeout() -> void:
	clicky -= 6700 * blobcat_amount # :3
	munch_sound.play()
	eating_animation.play("eating")
	eating_label.show()


func _on_button_5_pressed() -> void:
		if clicky >= 999:
			additional_clicks += 100
			clicky -= 999

func _on_button_5_mouse_entered() -> void:
	button5.text = "COST: 999 feed"
func _on_button_5_mouse_exited() -> void:
	button5.text = "+10 0  feed/click"


func _on_button_6_pressed() -> void:
	if clicky >= 15000 and not blobcat3_bought:
		clicky -= 15000
		blobcat3_animation.play("entry")
		random_meow()
		blobcat3_bought = true
		blobcat_amount += 2

func _on_button_6_mouse_entered() -> void:
	button6.text = "COST: 150 0 0 feed"


func _on_button_6_mouse_exited() -> void:
	button6.text = "Blob cat 3"


func _on_blobcat_3_animation_finished(anim_name: StringName) -> void:
	if anim_name == "entry":
		blobcat3_animation.play("loop")


func _on_button_7_pressed() -> void:
	if clicky >= 20000 and not blobcat4_bought:
		clicky -= 20000
		blobcat4_animation.play("entry")
		random_meow()
		blobcat4_bought = true
		blobcat_amount += 2


func _on_button_7_mouse_entered() -> void:
	button7.text = "COST: 200 0 0 feed"
func _on_button_7_mouse_exited() -> void:
	button7.text = "Blob cat 4"
