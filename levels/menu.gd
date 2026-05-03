extends Node2D

@export var main_scene: PackedScene

func _ready():
	ui.visible = false
	var all_animated_sprites = find_children("*", "AnimatedSprite2D")
	for sprite in all_animated_sprites:
		sprite.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
