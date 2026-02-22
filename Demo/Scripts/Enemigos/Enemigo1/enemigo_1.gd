extends CharacterBody2D
class_name Enemigo1

const GRAVITY_VALUE = 980
const SPEED_VALUE = 100

@export var daño = 10
@export var intervalo_ataque = 2.0 # Un golpe cada 2 segundo segundos

# Vector2 de la base aliada
var posicion_base_aliada

# Variables importantes para mover al enemigo solo
var velocidad_actual = Vector2.ZERO
var ultima_posicion = Vector2.ZERO

func _ready() -> void:
	# Guardar el valor de la posicion de la base aliada + guardar la posición del enemigo
	posicion_base_aliada = GlobalPosicionSpawneo.posicion_base_aliada
	ultima_posicion = global_position

func _physics_process(delta: float) -> void:
	# Efecto de la gravedad
	if not is_on_floor():
		añadir_gravedad(delta)
	
	# El movimiento ahora se controla desde los estados (walk.gd)
	move_and_slide() # Permite que se mueva
	
func movimiento_enemigo1(delta):
	# Si la posición es nula, intentar obtenerla de nuevo
	if posicion_base_aliada == null:
		posicion_base_aliada = GlobalPosicionSpawneo.posicion_base_aliada
	
	# Solo mover si tenemos un objetivo válido
	if posicion_base_aliada != null:
		global_position = global_position.move_toward(posicion_base_aliada, SPEED_VALUE * delta)
	
	# Calcular velocidad aproximada usando posiciones globales
	velocidad_actual = (global_position - ultima_posicion) / delta
	ultima_posicion = global_position
	# print("Velocidad actual del aliado1: ", velocidad_actual)
	
func añadir_gravedad(delta):
	position.y += GRAVITY_VALUE * delta
