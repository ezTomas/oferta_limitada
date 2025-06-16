extends Area2D

var interactuar: bool = false

func _process(delta: float) -> void:
	if interactuar and Input.is_action_just_pressed("Interactuar"):
		var jugadores = get_tree().get_nodes_in_group("player")
		if jugadores.size() > 0:
			var player = jugadores[0] # Asumimos que hay un solo player
			player.item_recogido("agua")
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		interactuar = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		interactuar = false
