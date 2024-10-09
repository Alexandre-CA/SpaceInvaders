extends Area2D
class_name Player

@export var speed = 200

signal player_destroyed

var direction = Vector2.ZERO
@onready var collision_rect: CollisionShape2D = $CollisionShape2D
@onready var  animation_player = $AnimationPlayer

var bounding_size_x 
var start_bound
var end_bound


func _ready():
	bounding_size_x = collision_rect.shape.get_rect().size.x / 2
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	start_bound = (camera_position.x - rect.size.x) / 2 # máximo de movimento para esquerda
	end_bound =  (camera_position.x + rect.size.x) / 2 # máximo de movimento para direita

func _process(delta):
	# START - Movimentação
	var screen_bounding_box = get_viewport_rect().end.x
	var input = Input.get_axis("move_left", "move_right")
	if input > 0:
		direction = Vector2.RIGHT
	elif  input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var deltaMovement = speed * delta * direction.x
	if position.x + deltaMovement < start_bound + bounding_size_x * transform.get_scale().x  || position.x + deltaMovement > end_bound - bounding_size_x * transform.get_scale().x: 
		return
	position.x += deltaMovement
	# END - Movimentação


func on_player_destroyed():
	speed = 0
	animation_player.play("destroy") # Iniciar animação de "destruir player"
	


func _on_animation_player_animation_finished(anim_name):
	# Ao finalizar a animação de "destroy"
	if anim_name == "destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit() # Emitir para os outros scripts que o player foi destruido
		queue_free() # Deletar Player


func _on_area_entered(area: Area2D) -> void:
	# Assim que o PowerUp entrar no Player
	if area is PowerUp:
		$ShotOrigin.shoot_config = area.config # Adicionar as config do PowerUp ao tiro
		area.queue_free() # Deletar PowerUp
