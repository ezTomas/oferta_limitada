extends CharacterBody2D

@export var speed: float = 190
@export var tiempo_cambio_direccion: float = 4.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer_direction: Timer = $Timer_direction
var is_facing_right: bool = true

const DIALOGO_NPC_NEGATIVO_1 = preload("res://Dialogos/dialogo_npc_negativo1.dialogue")
var is_player_close: bool = false
var is_dialogue_active: bool = false

func _process(delta: float) -> void:
	if is_player_close and not is_dialogue_active:
		DialogueManager.show_dialogue_balloon(DIALOGO_NPC_NEGATIVO_1, "start")

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_start)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	timer_direction.wait_time = tiempo_cambio_direccion
	timer_direction.start()
	#Al iniciar elige una direccion aleatoria para empezar a moverse
	nueva_direccion()

func _physics_process(delta: float) -> void:
	move_and_slide()
	# "get_last_slide_collision()" almacena la ultima colision que se haya realizado duran que este activa "move_and_slide()"
	if get_last_slide_collision() != null: #Sino es null  
		nueva_direccion() #Llama a la funcion

func nueva_direccion() -> void:
	#Almacena las 4 direccion posible de movimiento
	var direcciones = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT] 
	#elige una direccion aleatoria de la variable direcciones y la multiplica por speed
	velocity = direcciones[randi() % direcciones.size()] * speed

	
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x:
			animated_sprite.play("Caminar")
			
		if velocity.y > 0:
			animated_sprite.play("Abajo")
			
		if velocity.y < 0:
			animated_sprite.play("Arriba")
#si el jugador mira a la derecha y se mueve a la izquierda o si el juagdor mira a la izquierda y se mueve a la derecha
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		scale.x *= -1 #multiplica la escala en -1. Si era 1 pasa a ser -1 y si era -1 pasa a ser 1
		is_facing_right = not is_facing_right #cambia el booleano entre true y false segun corresponda
#Cuando pase el tiempo del timer llama a la funcion

func _on_timer_timeout() -> void:
	nueva_direccion()

func _on_area_2d_area_entered(area: Area2D) -> void:
	is_player_close = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	is_player_close = false

func _on_dialogue_start(dialogue):
	is_dialogue_active = true
	speed = 0

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(1.5).timeout
	is_dialogue_active = false
	speed = 190
