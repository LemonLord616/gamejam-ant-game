extends Area2D
class_name InteractArea


signal selected(size: Vector2, pos: Vector2)
signal deselected

@export var player: Player
@export var player_controller: PlayerController

var overlapping_areas: Array[InteractableArea] = []
var closest_area: InteractableArea = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	player_controller.interact.connect(_interact)

func _physics_process(delta: float) -> void:
	if overlapping_areas.is_empty():
		return

	var new_closest: InteractableArea = null
	var min_dist = INF
	
	for area in overlapping_areas:
		var dist := global_position.distance_squared_to(area.global_position)
		if dist < min_dist:
			min_dist = dist
			new_closest = area
	
	if new_closest != closest_area:
		closest_area = new_closest
		if closest_area != null:
			selected.emit(
				closest_area.get_selection_size(),
				closest_area.global_position
			)

func _on_area_entered(area: Area2D) -> void:
	if area is InteractableArea and not area in overlapping_areas:
		overlapping_areas.append(area)

func _on_area_exited(area: Area2D) -> void:
	overlapping_areas.erase(area)
	if overlapping_areas.is_empty():
		deselected.emit()

func _interact() -> void:
	if closest_area != null:
		closest_area.interact(player)
