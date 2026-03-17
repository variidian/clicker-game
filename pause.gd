extends Control
func _ready():
	get_tree().paused = true

func _on_button_pressed() -> void: #unpause
	get_tree().paused = false
	queue_free()


func _on_button_2_pressed() -> void:
	get_tree().quit()
