extends Mob
class_name LavendEnemy

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var ai_controller: AIController = %AIController
@onready var obstacle_raycast: RayCast2D = %ObstacleRaycast

@export_group("Settings")
@export var direction_timer_min := 2.0
@export var direction_timer_max := 3.5

var _direction_change_timer := .0

func _ready() -> void:
	animated_sprite.play("Run")
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	_handle_direction_timer(delta)
	
	obstacle_raycast.target_position = linear_velocity * delta
	if (obstacle_raycast.is_colliding()):
		_direction_change_timer = 0.0
	
	
func _handle_direction_timer(delta: float) -> void:
	_direction_change_timer -= delta
	
	if _direction_change_timer > 0.0:
		return
		
	_direction_change_timer = randf_range(
		direction_timer_min, 
		direction_timer_max)
	
	var direction := _random_unit_vector()
	ai_controller.set_move_direction(direction)
		
func _random_unit_vector() -> Vector2:
	return Vector2.from_angle(randf() * 2 * PI)
	
func _on_body_entered(_body: Node):
	_direction_change_timer = 0.0
	pass
