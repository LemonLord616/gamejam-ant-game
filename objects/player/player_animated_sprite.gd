extends AnimatedSprite2D
class_name PlayerAnimatedSprite


@export var player: Player
@export var player_controller: PlayerController

var is_player_moving := false
var is_player_running := false
var change_anim := true

func _ready() -> void:
	player_controller.player_move.connect(_idle_run_change)
	player_controller.player_direction.connect(_flip_h_change)
	player_controller.player_run.connect(_run_anim_speed)

func _physics_process(delta: float) -> void:
	if !change_anim:
		return
	if is_player_moving and is_player_running:
		play("Run2")
	elif is_player_moving:
		play("Run")
	else:
		play("Idle")
	change_anim = false

func _run_anim_speed(flag: bool) -> void:
	is_player_running = flag
	if flag:
		speed_scale = 1.3
	else:
		speed_scale = 1
	change_anim = true

func _idle_run_change(flag: bool) -> void:
	is_player_moving = flag
	change_anim = true

func _flip_h_change(is_right: bool) -> void:
	flip_h = is_right
