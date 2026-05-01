extends CanvasLayer
class_name UI

@onready var text_panel: Panel = %Text
@onready var label: RichTextLabel = %RichTextLabel
@onready var health_bar: TextureProgressBar = %Health
@onready var stamina_bar: TextureProgressBar = %Stamina

func _ready() -> void:
	text_panel.visible = false

func show_text(text: String) -> void:
	label.text = text
	text_panel.visible = true

func hide_text():
	text_panel.visible = false
