extends Control
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Interface/menu_principal.tscn")

func _ready() -> void:
	audio_stream_player.play()
