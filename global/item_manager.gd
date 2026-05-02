extends Node
class_name ItemManager

enum Item {
	LavendCup,
	Seed,
	RandomSeed,
	LavendSeed,
	SeaLavendSeed,
	SunnyLavendSeed,
	Lavend,
	SeaLavend,
	SunnyLavend,
	Coin,
}

static var item_resources: Dictionary[Item, ItemResource] = {
	Item.LavendCup: preload("res://items/lavend_cup.tres") as ItemResource,
	Item.Seed: preload("res://items/seed.tres") as ItemResource,
	Item.RandomSeed: preload("res://items/random_seed.tres") as ItemResource,
	Item.LavendSeed: preload("res://items/lavend_seed.tres") as ItemResource,
	Item.SeaLavendSeed: preload("res://items/sea_lavend_seed.tres") as ItemResource,
	Item.SunnyLavendSeed: preload("res://items/sunny_lavend_seed.tres") as ItemResource,
	Item.Lavend: preload("res://items/lavend.tres") as ItemResource,
	Item.SeaLavend: preload("res://items/sea_lavend.tres") as ItemResource,
	Item.SunnyLavend: preload("res://items/sunny_lavend.tres") as ItemResource,
	Item.Coin: preload("res://items/coin.tres") as ItemResource,
}
