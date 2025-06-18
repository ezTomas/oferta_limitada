extends CanvasLayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Pausa"):
		audio_stream_player.play()
		get_tree().paused = not get_tree().paused
		$".".visible = not $".".visible

func _on_volver_pressed() -> void:
	get_tree().paused = false
	$".".visible = false
	audio_stream_player.stop()
	var game = get_tree().get_nodes_in_group("Game")
	game[0].audio_stream_player.play()

func _on_controles_pressed() -> void:
	get_tree().paused = false
	$".".visible = false
	var escena_controles = preload("res://Scene/Interface/controles_pausa.tscn").instantiate()
	get_tree().current_scene.add_child(escena_controles)
	escena_controles.menu_pausa = self
	audio_stream_player.stop()

func _on_salir_pressed() -> void:
	get_tree().paused = false
	$".".visible = false
	get_tree().change_scene_to_file("res://Scene/Interface/menu_principal.tscn")
	queue_free()
	audio_stream_player.stop()

func mostrar_menu():
	$".".visible = true
	get_tree().paused = true
	audio_stream_player.play()
