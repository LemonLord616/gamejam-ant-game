extends Node
class_name SelectionVisuals

@export var interact_area: InteractArea
@export var sel_corner: Texture2D

var corner_sprites := []
var selected_node: Node2D = null
var corners: Array[Vector2] = []

func _ready() -> void:
	interact_area.selected.connect(create_selection)
	interact_area.deselected.connect(remove_selection)

func _physics_process(delta: float) -> void:
	if selected_node == null:
		return
	var pos = selected_node.global_position

	for i in range(4):
		var sprite = corner_sprites[i]
		sprite.global_position = pos + corners[i]

func remove_selection() -> void:
	for sprite in corner_sprites:
		if sprite is Sprite2D:
			sprite.queue_free()
	corner_sprites = []
	selected_node = null

func create_selection(size: Vector2, node: Node2D) -> void:
	remove_selection()
	var pos = node.global_position
	var w = size.x
	var h = size.y
	corners = [
		Vector2(-w/2, -h/2),
		Vector2(w/2, -h/2),
		Vector2(w/2, h/2),
		Vector2(-w/2, h/2),
	]
	var rotations := [0.0, 90.0, 180.0, 270.0]
	
	for i in 4:
		var sprite := Sprite2D.new()
		sprite.texture = sel_corner
		sprite.centered = false 
		sprite.global_position = pos + corners[i]
		sprite.rotation_degrees = rotations[i]
		get_tree().root.add_child(sprite)
		corner_sprites.append(sprite)
	selected_node = node
