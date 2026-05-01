extends Node
class_name AIController

signal mob_direction(is_right_dir: bool)
var is_mob_right_dir := false


@export var mob: Mob
@export var debug_raycast: RayCast2D

@export_range(1.0, 10.0, 0.5, "sec") var move_change_mean := 3.0
var move_vector := Vector2.ZERO
var move_timer := 0.0

@onready var motion_profile := mob.motion_profile

func _ready() -> void:
	mob.body_entered.connect(_on_mob_collided)

func _on_mob_collided(_body: Node) -> void:
	move_timer = 0.0

func _physics_process(delta: float) -> void:
	move_timer -= delta
	if move_timer < 0:
		_randomize_move_vector()

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
	
	if debug_raycast:
		debug_raycast.target_position = move_force
	
	mob.apply_force(move_force)

func _randomize_move_vector() -> void:
	move_vector = Vector2.from_angle(randf() * 2 * PI)
	var u = max(randf(), 0.0001)
	move_timer = -log(u) * move_change_mean
