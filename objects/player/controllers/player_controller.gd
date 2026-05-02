extends Node
class_name PlayerController

signal player_move(flag: bool)
signal player_direction(is_right_dir: bool)
signal player_run(flag: bool)
var is_player_moving := false
var is_player_right_dir := false
var is_player_running := false

signal interact
signal exit
signal drop

@export var enabled := true

@export var player: Player
@export var debug_raycast: RayCast2D
@export var stamina: PlayerStamina

@onready var player_id := player.player_id
@onready var device_id := player.device_id
@onready var motion_profile := player.motion_profile
@onready var prefix := "p" + str(player_id) + "_"

var can_run := true
## meant to disable run if stamina zeroed until press run again
var run_button_fresh := true

func _ready() -> void:
	if not enabled:
		queue_free()
	_setup_controls()
	stamina.can_run_change.connect(_on_can_run_change)

func _on_can_run_change(flag: bool) -> void:
	can_run = flag

func _setup_controls() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(prefix + "run"):
		run_button_fresh = true
	elif event.is_action_pressed(prefix + "interact"):
		interact.emit()
	elif event.is_action_pressed(prefix + "exit"):
		exit.emit()
	elif event.is_action_pressed(prefix + "drop"):
		drop.emit()

func _physics_process(delta: float) -> void:
	var move_vector := _get_move_vector()
	var power = motion_profile.power
	var max_force = motion_profile.max_force
	var is_running := Input.is_action_pressed(prefix + "run")
	if not can_run or not run_button_fresh:
		is_running = false
		run_button_fresh = false
	if is_running:
		power = motion_profile.run_power
		max_force = motion_profile.max_force
	if is_running != is_player_running:
		is_player_running = is_running
		player_run.emit(is_player_running)

	if move_vector.is_zero_approx() != !is_player_moving:
		is_player_moving = !is_player_moving
		player_move.emit(is_player_moving)

	if !is_zero_approx(move_vector.x) and move_vector.x < 0 != !is_player_right_dir:
		is_player_right_dir = !is_player_right_dir
		player_direction.emit(is_player_right_dir)

	if !move_vector.is_zero_approx():
		_apply_move(move_vector, power, max_force)
		return

	if is_player_moving and \
		player.linear_velocity.length() < motion_profile.decisive_stop_threshold:
		player.linear_velocity = Vector2.ZERO
		player.angular_velocity = 0.0

func _get_move_vector() -> Vector2:
	return Vector2.ZERO

func _apply_move(move_vector: Vector2, power: float, max_force: float) -> void:
	if move_vector.is_zero_approx():
		return

	var velocity := player.linear_velocity
	var effective_speed = move_vector.dot(velocity)
	
	var force_magnitude := 0.
	if is_zero_approx(effective_speed) or effective_speed < 0:
		force_magnitude = max_force
	else:
		force_magnitude = power / effective_speed
	
	var move_force = clamp(force_magnitude, 0, max_force) * move_vector
	
	if debug_raycast:
		debug_raycast.target_position = move_force
	
	player.apply_force(move_force)
