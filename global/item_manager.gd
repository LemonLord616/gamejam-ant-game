extends Node
class_name ItemManager

enum Item {
	LavendCup,
	Seed
}

static var item_resources: Dictionary[Item, ItemResource] = {
	Item.LavendCup: preload("res://items/lavend_cup.tres") as ItemResource,
	Item.Seed: preload("res://items/seed.tres") as ItemResource
}
