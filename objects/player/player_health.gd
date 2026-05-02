extends Node
class_name PlayerHealth

signal dead

@export var player: Player

@onready var max_health = player.max_health
@onready var bar := ui.health_bar

func _ready() -> void:
	bar.max_value = max_health
	bar.min_value = 0.0
	bar.step = 1.0
	bar.value = max_health

func reduce_health(amount: int) -> void:
	bar.value -= amount
	if is_zero_approx(bar.value):
		dead.emit()

func recover_health(amount: int) -> void:
	bar.value += amount
