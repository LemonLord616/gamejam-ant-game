extends Node
class_name ItemManager

enum Item {
	LavendCup,
	Seed,
	Lavend,
	SeaLavend,
}

static var item_resources: Dictionary[Item, ItemResource] = {
	Item.LavendCup: preload("res://items/lavend_cup.tres") as ItemResource,
	Item.Seed: preload("res://items/seed.tres") as ItemResource,
	Item.Lavend: preload("res://items/lavend.tres") as ItemResource,
	Item.SeaLavend: preload("res://items/sea_lavend.tres") as ItemResource,
}
