extends StaticBody2D
class_name Merchant


@onready var merchant_sprite: AnimatedSprite2D = %MerchantSprite
@onready var torch_sprite: AnimatedSprite2D = %TorchSprite

func _ready() -> void:
	merchant_sprite.play("default")
	torch_sprite.play("default")
