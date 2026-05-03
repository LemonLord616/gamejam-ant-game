extends RigidBody2D
class_name Mob

@export var motion_profile: MotionProfileResource
@export var time_to_live := 120

func _notification(what: int) -> void:
	if what == NOTIFICATION_READY:
		_on_ready()

func _on_ready() -> void:
	lock_rotation = true
	gravity_scale = 0.0
	global_clock.add_mob_die_queue(time_to_live, self)

func die() -> void:
	set_deferred("freeze", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$AttackArea.set_deferred("monitoring", false)
	$AttackArea.set_deferred("monitorable", false)	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.3).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.3)
	
	await tween.finished
	queue_free()
