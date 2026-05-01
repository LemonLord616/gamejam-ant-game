extends Area2D
class_name InteractArea


signal selected(size: Vector2, pos: Vector2)
signal deselected

@export var player: Player
@export var player_controller: PlayerController

var last_selected_area: InteractableArea

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	player_controller.interact.connect(_interact)

func _on_area_entered(area: Area2D) -> void:
	if area is InteractableArea:
		last_selected_area = area
		selected.emit(
			last_selected_area.get_selection_size(),
			last_selected_area.global_position
		)

func _on_area_exited(area: Area2D) -> void:
	if area == last_selected_area:
		deselected.emit()
		last_selected_area = null

func _interact() -> void:
	if last_selected_area == null:
		return
	last_selected_area.interact(player)
