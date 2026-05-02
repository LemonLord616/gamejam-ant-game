extends Node2D


@onready var y_sort_node: Node2D = %YSort

func _ready() -> void:
	YSort.y_sort_node = y_sort_node
