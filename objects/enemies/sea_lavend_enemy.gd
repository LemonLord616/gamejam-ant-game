extends Mob
class_name SeaLavendEnemy

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("Run")
