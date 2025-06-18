extends Area2D
var interactuar: bool = false

func _process(delta: float) -> void:
	var jugador = get_tree().get_nodes_in_group("player")
	if jugador[0].lista_completa == true:
		if interactuar and Input.is_action_just_pressed("Interactuar"):
			if jugador.size() > 0:
				var player = jugador[0] # Asumimos que hay un solo player
				player.item_recogido("picante")
			queue_free()


func _on_area_entered(area: Area2D) -> void:
	var jugador = get_tree().get_nodes_in_group("player")
	if area.is_in_group("player"):
		interactuar = true
	if area.is_in_group("npc_malo") and jugador[0].lista_completa == true:
		get_tree().change_scene_to_file("res://Scene/Interface/perder.tscn")

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		interactuar = false
