extends StaticBody2D
class_name Harvest


@onready var harvest_sprite: AnimatedSprite2D = %Harvest
@onready var interactable_area: InteractableArea = %InteractableArea
@onready var progress_bar: ProgressBar = %ProgressBar

enum Stage {
	SMALL, SPROUT, MATURE
}
enum Type {
	DEFAULT, SEA, SUNNY
}

@export_range(1.0, 15.0, 0.5, "sec") var growth_time := 7.0
var growth_timer := 0.0

@export var planted := false : set = _set_planted
@export var current_stage := Stage.SMALL : set = _set_harvest_stage
@export var current_type := Type.DEFAULT : set = _set_harvest_type

@export var monsters: Dictionary[Type, PackedScene]
@export_range(0.0, 1.0, 0.01) var monster_change = 0.5

func _set_planted(new_planted: bool) -> void:
	planted = new_planted
	harvest_sprite.visible = planted
	progress_bar.visible = planted

func _set_harvest_type(new_type: Type) -> void:
	current_type = new_type
	match current_type:
		Type.DEFAULT: harvest_sprite.play("Lavanda")
		Type.SEA: harvest_sprite.play("Sea Lavanda")
		Type.SUNNY: harvest_sprite.play("Sunny Lavanda")

func _set_harvest_stage(new_stage: Stage) -> void:
	current_stage = new_stage
	match current_stage:
		Stage.SMALL: harvest_sprite.frame = 0
		Stage.SPROUT: harvest_sprite.frame = 1
		Stage.MATURE: harvest_sprite.frame = 2
	
	if current_stage == Stage.MATURE:
		if randf() <= monster_change:
			_spawn_monster()
			planted = false

func _spawn_monster() -> void:
	var monster: Mob = monsters[current_type].instantiate()
	monster.global_position = global_position
	YSort.y_sort_node.add_child(monster)

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	harvest_sprite.speed_scale = 0
	planted = false
	
	progress_bar.min_value = 0.0
	progress_bar.max_value = growth_time
	progress_bar.value = 0.0
	progress_bar.visible = false

func _on_interact(player: Player) -> void:
	if not planted and not player.has_item():
		return
	if planted and player.has_item():
		return
	var item := player.get_item()
	if player.has_item() and item in [
		ItemManager.Item.LavendSeed,
		ItemManager.Item.SeaLavendSeed,
		ItemManager.Item.SunnyLavendSeed,
		ItemManager.Item.RandomSeed
	]:
		player.remove_item()
		_plant(item)

	if current_stage == Stage.MATURE:
		planted = false
		match current_type:
			Type.DEFAULT: player.set_item(ItemManager.Item.Lavend)
			Type.SEA:     player.set_item(ItemManager.Item.SeaLavend)
			Type.SUNNY:   player.set_item(ItemManager.Item.SunnyLavend)

func _plant(item: ItemManager.Item) -> void:
	planted = true
	current_stage = Stage.SMALL
	growth_timer = growth_time
	match item:
		ItemManager.Item.RandomSeed:
			current_type = randi() % Type.size() as Type
		ItemManager.Item.LavendSeed:
			current_type = Type.DEFAULT
		ItemManager.Item.SeaLavendSeed:
			current_type = Type.SEA
		ItemManager.Item.SunnyLavendSeed:
			current_type = Type.SUNNY

func _physics_process(delta: float) -> void:
	if not planted:
		return
	match current_stage:
		Stage.SMALL:
			if planted and growth_timer > 0:
				growth_timer -= delta
				progress_bar.value = growth_time - growth_timer
			elif planted:
				current_stage = Stage.SPROUT
				growth_timer = growth_time
		Stage.SPROUT:
			if planted and growth_timer > 0:
				growth_timer -= delta
				progress_bar.value = growth_time - growth_timer
			elif planted:
				current_stage = Stage.MATURE
		Stage.MATURE:
			pass
