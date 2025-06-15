extends CharacterBody2D
class_name player

var is_facing_right: bool = true
@export var speed: float = 300
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	move_x()
	move_y()
	flip_h()
	animacion()
	move_and_slide()
	
func move_x():
	var input_axis_x = Input.get_axis("Left", "Rigth") 
	velocity.x = input_axis_x * speed 

func move_y():
	var input_axis_y = Input.get_axis("Up","Down")
	velocity.y = input_axis_y * speed

func flip_h():
	#si el jugador mira a la derecha y se mueve a la izquierda o si el juagdor mira a la izquierda y se mueve a la derecha
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
			scale.x *= -1 #multiplica la escala en -1. Si era 1 pasa a ser -1 y si era -1 pasa a ser 1
			is_facing_right = not is_facing_right #cambia el booleano entre true y false segun corresponda

func animacion():
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x:
			animated_sprite.play("caminar_costado")
			
		if velocity.y > 0:
			animated_sprite.play("caminar_abajo")
			
		if velocity.y < 0:
			animated_sprite.play("caminar_arriba")
	else:
		animated_sprite.play("idle")

func start(pos):
	position = pos
	show()
