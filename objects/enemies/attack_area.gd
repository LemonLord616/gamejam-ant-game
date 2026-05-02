extends Area2D
class_name AttackArea


## Don't forget to set up collision mask!

@export_range(1000.0, 500000.0, 10.0) var knockback_impulse := 10000.0
@export var damage := 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var impulse_dir := (body.global_position - global_position).normalized()
		body.apply_impulse(impulse_dir * knockback_impulse)
		body.get_damage(damage)
