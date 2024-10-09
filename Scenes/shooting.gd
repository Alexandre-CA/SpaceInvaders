extends Node2D


@export var laser_scene:PackedScene
var shoot_config:PowerUpResource = preload("res://Resources/default_shoot.tres")
var can_shoot = true

func _input(event):
	if Input.is_action_just_pressed("shoot") && can_shoot:
		can_shoot = false
		var laser = laser_scene.instantiate() as Laser
		laser.laser_type = shoot_config
		laser.global_position = get_parent().global_position - Vector2(0, 20)
		get_tree().root.get_node("main").add_child(laser)
		laser.tree_exited.connect(on_laser_destroyed)

func on_laser_destroyed():
	can_shoot = true
