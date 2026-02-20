extends CharacterBody2D
class_name Aliado1

const GRAVITY_VALUE = 980
const SPEED_VALUE = 100

var posicion_base_enemiga

func _ready() -> void:
	posicion_base_enemiga = GlobalPosicionSpawneo.posicion_base_enemiga

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		añadir_gravedad(delta)
	
	movimiento_aliado1(delta)
	move_and_slide()
	
func movimiento_aliado1(delta):
	position = position.move_toward(posicion_base_enemiga,SPEED_VALUE * delta)
	
func añadir_gravedad(delta):
	position.y += GRAVITY_VALUE * delta
