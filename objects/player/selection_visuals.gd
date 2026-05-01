extends Node
class_name SelectionVisuals

@export var interact_area: InteractArea
@export var sel_corner: Texture2D

var corner_sprites := []

func _ready() -> void:
	interact_area.selected.connect(create_selection)
	interact_area.deselected.connect(remove_selection)

func remove_selection() -> void:
	for sprite in corner_sprites:
		if sprite is Sprite2D:
			sprite.queue_free()
	corner_sprites = []

func create_selection(size: Vector2, pos: Vector2) -> void:
	remove_selection()
	var w = size.x
	var h = size.y
	var corners := [
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
