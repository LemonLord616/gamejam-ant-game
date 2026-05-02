extends Mob
class_name SeaLavendEnemy

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var obstacle_raycast: RayCast2D = %ObstacleRaycast
@onready var trajectory_line: Line2D = %TrajectoryLine

@export_group("Settings")
@export var target_min_distance := 64.0;
@export var target_select_timer_min := 1.0
@export var target_select_timer_max := 3.0
@export var target_line_length_min := 3.0
@export var target_line_length_max := 3.0

var _target_timer := .0
var _target_position : Vector2
var _start_following_position : Vector2
var _previous_position : Vector2
var _following_target := false

func _ready() -> void:
	animated_sprite.play("Run")
	_reset_target_timer()
	linear_damp = motion_profile.damp
	trajectory_line.position = Vector2.ZERO
	trajectory_line.add_point(Vector2.ZERO, 0)
	trajectory_line.add_point(Vector2.ZERO, 1)

func _process(delta: float) -> void:
	trajectory_line.set_point_position(0, _start_following_position - global_position)
	trajectory_line.set_point_position(1, _target_position - global_position)

func _physics_process(delta: float) -> void:
	if (!_following_target):
		_handle_target_timer(delta)
	else:
		_move_to_target(delta)
	
	obstacle_raycast.target_position = linear_velocity * delta * 6
	if (obstacle_raycast.is_colliding()):
		_reset_target_timer()
	_previous_position = global_position


func _move_to_target(delta: float) -> void:
	var direction := _target_position - position
	
	apply_force(direction.normalized() * motion_profile.power)
	
	if (direction.length() >= target_min_distance):
		return
		
	# if reached target
	_reset_target_timer()
	trajectory_line.visible = false


func _reset_target_timer() -> void:
	print("Target timer is on, not targeting!")
	_following_target = false
	_target_timer = randf_range(
		target_select_timer_min, 
		target_select_timer_max)


func _handle_target_timer(delta: float) -> void:
	_target_timer -= delta
	
	if _target_timer > 0.0:
		return
	
	print("Targeting player!")
	_following_target = true
	var direction := PositionTracker.current_position - global_position
	direction = direction.normalized()
	var extra_length := randf_range(
		target_line_length_min, 
		target_line_length_max)
		
	_target_position = PositionTracker.current_position + direction * extra_length
	_start_following_position = global_position
	
	trajectory_line.visible = true


func _random_unit_vector() -> Vector2:
	return Vector2.from_angle(randf() * 2 * PI)
