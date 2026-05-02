extends Sprite2D
class_name Shadow

@export var node_follow: Node2D
@export var _offset := Vector2.ZERO

func _ready() -> void:
	node_follow.tree_exiting.connect(queue_free)

func _physics_process(_delta: float) -> void:
	global_position = node_follow.global_position + _offset
