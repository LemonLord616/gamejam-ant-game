extends Node2D
class_name Projectile

@onready var attack_area: AttackArea = %AttackArea
@onready var sprite_2d: Sprite2D = %Sprite2D

@export_group("Settings")
@export var speed := 64.0
@export var scale_tween_duration := 0.4
@export var scale_disappear_duration := 0.2
@export var lifetime := 8.0

var move_direction : Vector2
var life_timer := 0.0

func _ready() -> void:
	life_timer = lifetime
	attack_area.damaged.connect(_on_damaged)
	
	var tween := create_tween()
	sprite_2d.scale = Vector2.ZERO
	tween.tween_property(
		sprite_2d,
		"scale",
		Vector2.ONE,
		scale_tween_duration
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_damaged() -> void:
	var tween := create_tween()
	sprite_2d.scale = Vector2.ONE
	tween.tween_property(
		sprite_2d,
		"scale",
		Vector2.ZERO,
		scale_tween_duration
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(scale_disappear_duration).timeout
	
	queue_free()

func _physics_process(delta: float) -> void:
	life_timer -= delta
	if life_timer <= 0.0:
		queue_free()
		return
	
	global_position += move_direction * speed * delta


func set_move_direction(direction: Vector2) -> void:
	move_direction = direction
