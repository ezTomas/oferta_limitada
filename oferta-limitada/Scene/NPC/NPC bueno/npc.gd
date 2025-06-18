extends CharacterBody2D

@export var speed : float = 70 #Variable de velocidad
@export var max_distancia : float = 300 #Distancia maxima de movimiento
@export var direccion : Vector2 = Vector2.DOWN #Direccion incial de movimiento

@onready var animation_sprite: AnimatedSprite2D = $AnimatedSprite2D #Referencia el AnimatedSprite2D
@onready var start_position: Vector2 = global_position #Toma la ubicacion del character dentro de la escena "game"

var direccion_movimiento: Vector2 #Variable para la referencia del movimiento
var moviendo_abajo = true #Variable para saber si se mueve para abajo

const NPC_BUENO_2 = preload("res://Dialogos/npc_bueno2.dialogue")
var is_player_close = false
var is_dialogue_active = false
@onready var jugador = get_tree().get_nodes_in_group("player")

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_start)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

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


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		is_player_close = true
	if is_player_close and not is_dialogue_active:
		speed = 0
		DialogueManager.show_dialogue_balloon(NPC_BUENO_2, "start")
		jugador[0].speed = 0

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		is_player_close = false
		is_dialogue_active = true

func _on_dialogue_start(dialogue):
	pass

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(1.5).timeout
	is_dialogue_active = false
	speed = 70
	jugador[0].speed = 300
