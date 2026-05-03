extends AudioStreamPlayer


func _ready() -> void:
	finished.connect(_on_finished)

func _on_finished() -> void:
	await get_tree().create_timer(5.0).timeout
	play()
