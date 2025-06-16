extends Control


func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/game.tscn")


func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Interface/controles.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
