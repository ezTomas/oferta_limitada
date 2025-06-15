extends CharacterBody2D

@export var speed : float = 70
@export var max_distancia : float = 190
@export var direccion : Vector2 = Vector2.LEFT
var is_facing_right: bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var start_position: Vector2 = global_position

var direccion_movimiento: Vector2 
var moviendo_derecha = true #Variable para saber si se mueve para la derecha

func _process(delta: float) -> void:
	flip_h()
	animacion()

func _physics_process(delta: float) -> void:
	if moviendo_derecha:  #Si se mueve para la direccion que se indica con la variable "Direccion"
		direccion_movimiento = direccion #asigan la variable "Direccion" a "direccion_movimiento"

	else: #sino
		direccion_movimiento = -direccion #asigna "direccion_movimiento" a la direccion contraria
		
	velocity = direccion_movimiento * speed #Se mueve para la direccion que corresponda
	move_and_slide()

	#cualcula que la distancia inicial del NPC cuando se da play y si es mayor al maximo establecido
	if global_position.distance_to(start_position) > max_distancia: 
		#si es mayor cambia la variable para que se mueva en direccion contraria
		moviendo_derecha = not moviendo_derecha
		
func animacion():
	if velocity.x:
		animated_sprite.play("Costado")

func flip_h():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
			scale.x *= -1
			is_facing_right = not is_facing_right
