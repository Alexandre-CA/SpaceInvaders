extends Area2D

func _on_area_entered(area):
	# Assim que entrar Tiro no barreira
	if area is Laser: 
		area.queue_free() # Deletar Tiro
