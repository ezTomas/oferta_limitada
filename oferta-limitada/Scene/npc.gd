extends CharacterBody2D

@onready var animation_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animation_sprite.play("Caminar")
