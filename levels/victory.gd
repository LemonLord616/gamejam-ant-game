extends Control

@export var main_scene: PackedScene
@export var menu_scene: PackedScene

func _ready() -> void:
	ui.visible = false
	global_clock.timer_stop()

func _on_retry_button_pressed():
	get_tree().change_scene_to_packed(main_scene)

func _on_menu_button_pressed():
	get_tree().change_scene_to_packed(menu_scene)
