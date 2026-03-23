extends Control
func _ready():
	get_tree().paused = true

func _on_button_pressed() -> void: #unpause
	get_tree().paused = false
	queue_free()

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_3_pressed() -> void:
	if FileAccess.file_exists("user://savegame.save"):
		DirAccess.remove_absolute("user://savegame.save")
	get_tree().quit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = false
		queue_free()
