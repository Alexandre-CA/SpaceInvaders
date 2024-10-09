extends Area2D

class_name Laser
@export var speed = 300
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var laser_type:PowerUpResource
@onready var sprite:Sprite2D = $Sprite2D
var explosion_area = preload("res://Scenes/explosion.tscn")

func _ready() -> void:
	sprite.texture = laser_type.shoot_sprite
	if(laser_type.action == 0):
		$CollisionShape2D.scale = Vector2(5,1)
func _process(delta):
	position.y -= delta * speed
	
func explosion():
	var explosion = explosion_area.instantiate() as Area2D
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	
	var timer:Timer = Timer.new()
	get_tree().root.add_child(timer)
	var queue = func queue_func():
		explosion.queue_free()
		timer.queue_free()
	# Configura o Timer para o tempo desejado
	timer.wait_time = 0.2
	timer.timeout.connect(queue)
	
	timer.start()
	
