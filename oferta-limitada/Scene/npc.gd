extends CharacterBody2D

@export var speed : float = 70 #Variable de velocidad
@export var max_distancia : float = 300 #Distancia maxima de movimiento
@export var direccion : Vector2 = Vector2.DOWN #Direccion incial de movimiento

@onready var animation_sprite: AnimatedSprite2D = $AnimatedSprite2D #Referencia el AnimatedSprite2D
@onready var start_position: Vector2 = global_position #Toma la ubicacion del character dentro de la escena "game"

var direccion_movimiento: Vector2 #Variable para la referencia del movimiento
var moviendo_abajo = true #Variable para saber si se mueve para abajo

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if moviendo_abajo:  #Si se mueve para la direccion que se indica con la variable "Direccion"
		direccion_movimiento = direccion #asigan la variable "Direccion" a "direccion_movimiento"
		animation_sprite.play("Caminar_Abajo")
	else: #sino
		direccion_movimiento = -direccion #asigna "direccion_movimiento" a la direccion contraria
		animation_sprite.play("Caminar_Arriba")
	velocity = direccion_movimiento * speed #Se mueve para la direccion que corresponda
	move_and_slide()

	#cualcula que la distancia inicial del NPC cuando se da play y si es mayor al maximo establecido
	if global_position.distance_to(start_position) > max_distancia: 
		#si es mayor cambia la variable para que se mueva en direccion contraria
		moviendo_abajo = not moviendo_abajo
