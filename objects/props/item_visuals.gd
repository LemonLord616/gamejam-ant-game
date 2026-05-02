extends Node2D
class_name ItemVisuals

@export var done_mark: Texture2D
var sprites: Array[Sprite2D] = []
var done_marks: Array[Sprite2D] = []
## Recommend make it even
var sprite_hsize := 16

func mark_done(idx: int) -> void:
	var left = - sprites.size() * sprite_hsize / 2
	var sprite = Sprite2D.new()
	sprite.texture = done_mark
	sprite.position = Vector2(
		left + sprite_hsize / 2 + sprite_hsize * idx, 0
	)
	add_child(sprite)
	done_marks[idx] = sprite

func unmark_done(idx: int) -> void:
	done_marks[idx].queue_free()
	done_marks[idx] = null

func clear_item_sprites() -> void:
	for sprite in sprites:
		sprite.queue_free()
	for mark in done_marks:
		if mark != null:
			mark.queue_free()
	sprites = []
	done_marks = []

func create_item_sprites(items: Array[ItemManager.Item]) -> void:
	clear_item_sprites()
	var size = items.size()
	done_marks.resize(size)
	done_marks.fill(null)
	var left = - size * sprite_hsize / 2
	for i in range(size):
		var texture = ItemManager.item_resources[items[i]].texture
		var sprite := Sprite2D.new()
		sprite.texture = texture
		sprite.position = Vector2(
			left + sprite_hsize / 2 + sprite_hsize * i, 0
		)
		add_child(sprite)
		sprites.append(sprite)
	print(sprites)
	print(global_position)
	for sprite in sprites:
		print(sprite.global_position)
