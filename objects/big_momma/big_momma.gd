extends StaticBody2D
class_name BigMomma

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var progress_bar: ProgressBar = %ProgressBar

@export var stage1_capacity: int = 2
@export var stage2_capacity: int = 3
@export var stage3_capacity: int = 5 

enum Stage {
	ONE, TWO, THREE
}
var current_stage := Stage.ONE : set = _on_stage_change
var counter := 0 : set = _on_counter_change

var raphs_needed: Dictionary[Stage, int] = {
	Stage.ONE: stage1_capacity,
	Stage.TWO: stage2_capacity,
	Stage.THREE: stage3_capacity,
}

func _on_stage_change(new_stage: Stage) -> void:
	current_stage = new_stage
	progress_bar.max_value = raphs_needed[current_stage]
	progress_bar.value = 0
	counter = 0
	match current_stage:
		Stage.ONE: animated_sprite.play("Stage1")
		Stage.TWO: animated_sprite.play("Stage2")
		Stage.THREE: animated_sprite.play("Stage3")

func _on_counter_change(new_counter: int) -> void:
	counter = new_counter
	progress_bar.value = counter
	if counter >= raphs_needed[current_stage]:
		match current_stage:
			Stage.ONE: current_stage = Stage.TWO
			Stage.TWO: current_stage = Stage.THREE
			Stage.THREE: pass # TODO: add win

func _ready() -> void:
	current_stage = Stage.ONE
	progress_bar.min_value = 0
	interactable_area.interacted.connect(_on_interact)

func _on_interact(player: Player) -> void:
	if player.is_item(ItemManager.Item.Food):
		player.remove_item()
		counter = counter + 1
