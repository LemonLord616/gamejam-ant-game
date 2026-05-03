extends Timer
class_name Clock

signal second_passed

static var timer := 0

static var mob_die_queue: Dictionary[int, Array] = {}

func _ready() -> void:
	timeout.connect(_on_timeout)
	timeout.connect(_check_monsters)
	wait_time = 1.0
	start()

func add_mob_die_queue(time_to_live: int, mob: Mob) -> void:
	if time_to_live <= 1:
		mob.die()
		return
	if mob_die_queue.has(timer + time_to_live):
		mob_die_queue[timer + time_to_live].append(mob)
	else:
		mob_die_queue[timer + time_to_live] = [mob]

func _on_timeout() -> void:
	timer += 1
	second_passed.emit()

func _check_monsters() -> void:
	if mob_die_queue.has(timer):
		for mob: Mob in mob_die_queue[timer]:
			mob.die()
