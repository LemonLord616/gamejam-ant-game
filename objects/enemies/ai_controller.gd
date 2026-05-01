extends Node
class_name AIController

signal mob_direction(is_right_dir: bool)
var is_mob_right_dir := false

@export var mob: Mob

var move_vector := Vector2.ZERO

@onready var motion_profile := mob.motion_profile

func _physics_process(delta: float) -> void:
	var power = motion_profile.power
	var max_force = motion_profile.max_force

	if !is_zero_approx(move_vector.x) and move_vector.x < 0 != !is_mob_right_dir:
		is_mob_right_dir = !is_mob_right_dir
		mob_direction.emit(is_mob_right_dir)

	if !move_vector.is_zero_approx():
		_apply_move(power, max_force)
		return

func _apply_move(power: float, max_force: float) -> void:
	if move_vector.is_zero_approx():
		return

	var velocity := mob.linear_velocity
	var effective_speed = move_vector.dot(velocity)
	
	var force_magnitude := 0.
	if is_zero_approx(effective_speed) or effective_speed < 0:
		force_magnitude = max_force
	else:
		force_magnitude = power / effective_speed
	
	var move_force = clamp(force_magnitude, 0, max_force) * move_vector
	
	mob.apply_force(move_force)

#func _randomize_move_vector() -> void:
	#move_vector = Vector2.from_angle(randf() * 2 * PI)
	#var u = max(randf(), 0.0001)
	#move_timer = -log(u) * move_change_mean
	
func set_move_direction(direction: Vector2) -> void:
	move_vector = direction
	pass
