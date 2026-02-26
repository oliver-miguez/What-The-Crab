extends CharacterBody2D
class_name Enemigo1

const GRAVITY_VALUE = 980
const SPEED_VALUE = 100

@export var daño = 10
@export var intervalo_ataque = 2.0 # Un golpe por segundo

@onready var label_vida: Label = $LabelVida

var posicion_base_aliada

var velocidad_actual = Vector2.ZERO
var ultima_posicion = Vector2.ZERO

var atacando:bool
var objetivo_actual:Aliado1 = null

var vida_maxima = 80
var vida_actual = 80

func _ready() -> void:
	label_vida.text = str(vida_actual)
	posicion_base_aliada = GlobalPosicionSpawneo.posicion_base_aliada
	ultima_posicion = global_position

func _physics_process(delta: float) -> void:
	label_vida.text = str(vida_actual)
	if not is_on_floor():
		añadir_gravedad(delta)
	
	# El movimiento ahora se controla desde los estados (walk.gd)
	move_and_slide()
	
func movimiento_enemigo1(delta):
	if objetivo_actual != null:
		return
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

func recibir_daño(cantidad_daño:int):
	print("[Enemigos]: Estoy recibiendo daño de los aliados")
	# Quitar vida al aliado 
	vida_actual = vida_actual - cantidad_daño;
	# Si no tiene vida muere
	if vida_actual <= 0:
		morir()

func morir():
	print("[Enemigos] Un enemigo a muerto")
	queue_free()
	
func añadir_gravedad(delta):
	position.y += GRAVITY_VALUE * delta

## Detección de aliados
func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	if body.is_in_group("Aliados"):
		print("[ENEMIGOS] aliado detectado en : ",self.name)
		objetivo_actual = body
		atacando = true

func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	if body.is_in_group("Aliados"):
		print("[ENEMIGOS] Deje de detectar al aliado : ",self.name)
		objetivo_actual = null
		atacando = false
