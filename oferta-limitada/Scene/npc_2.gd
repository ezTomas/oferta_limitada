extends CharacterBody2D

@export var speed : float = 70 #Variable de velocidad
@export var max_distancia : float = 190 #Distancia maxima de movimiento
@export var direccion : Vector2 = Vector2.RIGHT #Direccion incial de movimiento
var is_facing_right: bool = true #Booleano para saber si mira a la izquierda

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D #Referencia el AnimatedSprite2D
@onready var start_position: Vector2 = global_position #Toma la ubicacion del character dentro de la escena "game"

var direccion_movimiento: Vector2 #Variable para la referencia del movimiento
var moviendo_izquierda= true #Variable para saber si se mueve para la izquierda

func _process(delta: float) -> void:
	flip_h() #Llamm a la funcion
	animacion() #Llamm a la funcion

func _physics_process(delta: float) -> void:
	if moviendo_izquierda:  #Si se mueve para la direccion que se indica con la variable "Direccion"
		direccion_movimiento = direccion #asigan la variable "Direccion" a "direccion_movimiento"
	else: #sino
		direccion_movimiento = -direccion #asigna "direccion_movimiento" a la direccion contraria
	velocity = direccion_movimiento * speed #Se mueve para la direccion que corresponda
	move_and_slide()

	#cualcula que la distancia inicial del NPC cuando se da play y si es mayor al maximo establecido
	if global_position.distance_to(start_position) > max_distancia: 
		#si es mayor cambia la variable para que se mueva en direccion contraria
		moviendo_izquierda = not moviendo_izquierda
		
func animacion(): #si se mueve dentro del eje X, reproduce la animacion 
	if velocity.x:
		animated_sprite.play("Costado")

func flip_h():
	#si el jugador mira a la derecha y se mueve a la izquierda o si el juagdor mira a la izquierda y se mueve a la derecha
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
			scale.x *= -1 #multiplica la escala en -1. Si era 1 pasa a ser -1 y si era -1 pasa a ser 1
			is_facing_right = not is_facing_right #cambia el booleano entre true y false segun corresponda
