extends Node2D
class_name FloatingItem


@export var player: Player
@export var follow_curve: Curve
@export_range(100.0, 1000.0, 1.0) var max_distance: float = 400.0
@export var offset: Vector2
var current_item: ItemResource

@onready var sprite: Sprite2D = %ItemSprite
@onready var label: Label = %ItemLabel

func _ready() -> void:
	player.item_changed.connect(_on_item_changed)
	player.item_discarded.connect(_on_item_discared)

func _on_item_discared() -> void:
	sprite.texture = null
	label.text = ""

func _on_item_changed(item_res: ItemResource) -> void:
	if item_res == null:
		_on_item_discared()
		return
	current_item = item_res
	sprite.texture = item_res.texture
	label.text = item_res.name

func _physics_process(delta: float) -> void:
	var distance := global_position.distance_to(player.global_position + offset)
	var t = clamp(distance / max_distance, 0.0, 1.0)
	var curve_value := follow_curve.sample(t)
	global_position = global_position.lerp(
		player.global_position + offset, curve_value
	)
