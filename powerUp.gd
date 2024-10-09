extends Area2D

class_name PowerUp
var config: Resource
var SPEED = 100

func _ready() -> void:
	$Sprite2D.texture = config.sprite_1

func _process(delta: float) -> void:
	position.y += delta * SPEED
