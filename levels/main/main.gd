extends Node2D


@onready var y_sort_node: Node2D = %YSort

func _ready() -> void:
	ui.visible = true
	YSort.y_sort_node = y_sort_node
	global_clock.timer_start()
