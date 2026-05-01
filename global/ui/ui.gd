extends CanvasLayer
class_name UI

@export var text_panel: Panel
@export var label: RichTextLabel

func _ready() -> void:
	text_panel.visible = false

func show_text(text: String) -> void:
	label.text = text
	text_panel.visible = true

func hide_text():
	text_panel.visible = false
