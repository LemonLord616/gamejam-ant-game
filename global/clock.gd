extends Timer
class_name Clock

signal second_passed

static var timer := 0

func _ready() -> void:
	timeout.connect(_on_timeout)
	wait_time = 1.0
	start()

func _on_timeout() -> void:
	timer += 1
	second_passed.emit()
