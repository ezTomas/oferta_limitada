extends CanvasLayer

var menu_pausa = null

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	var game = get_tree().get_nodes_in_group("Game")
	game[0].audio_stream_player.stop()
	audio_stream_player.play()

func _on_button_pressed() -> void:
	if menu_pausa:
		menu_pausa.mostrar_menu()
	audio_stream_player.stop()
	queue_free()
