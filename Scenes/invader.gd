extends Area2D

class_name Invader
signal on_invader_destroyed(points: int)

var config: Resource
@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var power_up_scene = preload("res://Scenes/power_up.tscn")

var power_up_01_res = preload("res://Resources/powerUp_1.tres")
var power_up_02_res = preload("res://Resources/powerUp_2.tres")
var power_up_03_res = preload("res://Resources/powerUp_3.tres")

func _ready():
	sprite.texture = config.sprite_1
	animation_player.play(config.animation_name)


func _on_area_entered(area):
	if area is Explosion:
		animation_player.play("destroy")
	if area is Laser:
		animation_player.play("destroy")
		if(area.laser_type.action == -1):
			area.queue_free()
		elif(area.laser_type.action == 0):
			area.queue_free()
			pass
		elif(area.laser_type.action == 1):
			pass
		elif(area.laser_type.action == 2):
			area.explosion()
			area.queue_free() 
		
func spawn_power_up():
	var power_up_config:Resource = [power_up_01_res,power_up_02_res,power_up_03_res].pick_random()	
	#var power_up_config:Resource = [power_up_03_res].pick_random()	
	
	var power_up = power_up_scene.instantiate() as PowerUp
	power_up.config = power_up_config
	power_up.global_position = global_position
	get_tree().root.add_child(power_up)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
		on_invader_destroyed.emit(config.points)
		#var random = [3].pick_random()
		var random = [1,2,3,4,5,6,7,8].pick_random()
		if random == 3:
			spawn_power_up()

		
