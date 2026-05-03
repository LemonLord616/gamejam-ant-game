extends Node2D


@export var kb_player: PackedScene
@export var gp_player: PackedScene
@export var floating_item: PackedScene

@onready var y_sort_node: Node2D = %YSort
@onready var camera: Camera2D = %Camera2D
func _ready() -> void:
	ui.visible = true
	YSort.y_sort_node = y_sort_node
	var player: Player
	var f_item: FloatingItem = floating_item.instantiate()
	if GlobalDevice.selected_device == GlobalDevice.Device.GAMEPAD:
		player = gp_player.instantiate()
	else:
		player = kb_player.instantiate()
	camera.player = player
	player.floating_item = f_item
	f_item.player = player
	YSort.y_sort_node.add_child(player)
	YSort.y_sort_node.add_child(f_item)
	
	global_clock.timer_start()
