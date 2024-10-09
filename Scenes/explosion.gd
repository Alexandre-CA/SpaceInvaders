extends Area2D

class_name Explosion
var sprite_scale_size:float = 1
var colision_scale_size:float = 1
@onready var explosion_expand: Timer = $ExplosionExpand

func _ready() -> void:
	
	explosion_expand.timeout.connect(expand)
	
func expand():
	sprite_scale_size+= 1
	colision_scale_size+=1
	$CollisionShape2D.apply_scale(Vector2(colision_scale_size,colision_scale_size))
	$Sprite2D.apply_scale(Vector2(sprite_scale_size,sprite_scale_size))
	

func _process(delta: float) -> void:
	pass
