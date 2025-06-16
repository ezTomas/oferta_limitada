extends CharacterBody2D

@export var speed: float = 190
@export var tiempo_cambio_direccion: float = 4.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


func _ready() -> void:
	animated_sprite.play("Caminar")
	timer.wait_time = tiempo_cambio_direccion
	timer.start()
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

#Cuando pase el tiempo del timer llama a la funcion
func _on_timer_timeout() -> void:
	nueva_direccion()
