extends Control

@export var main_scene: PackedScene
@export var menu_scene: PackedScene

@onready var timer_label: Label = %TimerLabel

func _ready() -> void:
	ui.visible = false
	global_clock.timer_stop()
	_update_time_display()

func _on_retry_button_pressed():
	get_tree().change_scene_to_packed(main_scene)

func _on_menu_button_pressed():
	get_tree().change_scene_to_packed(menu_scene)

func _update_time_display():
	var time = global_clock.timer
	var minutes = floor(time / 60)
	var seconds = time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
