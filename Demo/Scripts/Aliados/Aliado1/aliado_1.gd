extends CharacterBody2D
class_name Aliado1

const GRAVITY_VALUE = 980
const SPEED_VALUE = 100

var posicion_base_enemiga

var velocidad_actual = Vector2.ZERO
var ultima_posicion = Vector2.ZERO

func _ready() -> void:
	posicion_base_enemiga = GlobalPosicionSpawneo.posicion_base_enemiga
	ultima_posicion = global_position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		añadir_gravedad(delta)
	
	# El movimiento ahora se controla desde los estados (walk.gd)
	move_and_slide()
	
func movimiento_aliado1(delta):
	# Si la posición es nula, intentar obtenerla de nuevo
	if posicion_base_enemiga == null:
		posicion_base_enemiga = GlobalPosicionSpawneo.posicion_base_enemiga
	
	# Solo mover si tenemos un objetivo válido
	if posicion_base_enemiga != null:
		global_position = global_position.move_toward(posicion_base_enemiga, SPEED_VALUE * delta)
	
	# Calcular velocidad aproximada usando posiciones globales
	velocidad_actual = (global_position - ultima_posicion) / delta
	ultima_posicion = global_position
	# print("Velocidad actual del aliado1: ", velocidad_actual)
	
func añadir_gravedad(delta):
	position.y += GRAVITY_VALUE * delta
