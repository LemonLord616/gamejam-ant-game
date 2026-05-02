extends Node
class_name PlayerStamina


signal can_run_change(flat: bool)

@export var player_controller: PlayerController
@export var player: Player

@onready var run_full_duration = player.run_full_duration
@onready var bar := ui.stamina_bar
var is_running := false
var stamina_zero := false

func _ready() -> void:
	bar.max_value = run_full_duration
	bar.min_value = 0.0
	bar.step = 0.0001
	bar.value = run_full_duration
	player_controller.player_run.connect(_on_player_run)

func _physics_process(delta: float) -> void:
	if is_running:
		bar.value -= delta
	elif bar.value < bar.max_value:
		bar.value += delta
	if is_zero_approx(bar.value) and not stamina_zero:
		can_run_change.emit(false)
		stamina_zero = true
	elif stamina_zero:
		can_run_change.emit(true)
		stamina_zero = false
	

func _on_player_run(flag: bool) -> void:
	is_running = flag
