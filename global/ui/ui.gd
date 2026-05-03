extends CanvasLayer
class_name UI

@onready var text_panel: Panel = %Text
@onready var label: RichTextLabel = %RichTextLabel
@onready var health_bar: TextureProgressBar = %Health
@onready var stamina_bar: TextureProgressBar = %Stamina

@onready var timer_label: Label = %TimerLabel

func _ready() -> void:
	global_clock.second_passed.connect(_update_time_display)
	text_panel.visible = false
	_update_time_display()

func _update_time_display():
	var time = global_clock.timer
	var minutes = floor(time / 60)
	var seconds = time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func show_text(text: String) -> void:
	label.text = text
	text_panel.visible = true

func hide_text():
	text_panel.visible = false
