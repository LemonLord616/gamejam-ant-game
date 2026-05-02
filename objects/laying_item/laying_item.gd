extends RigidBody2D
class_name LayingItem

@export var shadow_scene: PackedScene
@export_range(0.0, 10.0, 0.1) var damp := 5.0
@onready var sprite: Sprite2D = %Sprite2D
@onready var interactable_area: InteractableArea = %InteractableArea
var item: ItemManager.Item : set = _on_set_item

func _on_set_item(new_item: ItemManager.Item) -> void:
	item = new_item
	sprite.texture = ItemManager.item_resources[item].texture

func set_item(new_item: ItemManager.Item) -> void:
	item = new_item

func _ready() -> void:
	gravity_scale = 0.0
	lock_rotation = true
	interactable_area.interacted.connect(_on_interact)
	var shadow: Shadow = shadow_scene.instantiate()
	shadow.node_follow = self
	YSort.y_sort_node.add_child(shadow)

func _physics_process(_delta: float) -> void:
	apply_force(-linear_velocity * damp)

func _on_interact(player: Player) -> void:
	if player.has_item():
		return
	player.set_item(item)
	queue_free()
	
