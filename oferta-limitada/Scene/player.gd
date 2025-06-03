extends Area2D
class_name player

@export var Speed: float = 300
var screen_size 

func _ready() -> void:
	screen_size = get_viewport_rect().size
	

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Rigth"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1

	position += velocity * delta * Speed
	position = position.clamp(Vector2.ZERO, screen_size)
	
func start(pos):
	position = pos
	show()
