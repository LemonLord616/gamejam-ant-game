extends RigidBody2D
class_name Mob

@export var motion_profile: MotionProfileResource

func _notification(what: int) -> void:
	if what == NOTIFICATION_READY:
		_on_ready()

func _on_ready() -> void:
	lock_rotation = true
	gravity_scale = 0.0
