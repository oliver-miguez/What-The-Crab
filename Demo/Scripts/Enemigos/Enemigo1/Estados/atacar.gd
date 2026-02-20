extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"

# Definir los estados a los que puede cambiar
@export var estado_andar:State
const RANGO_PERDIDA = 180.0

var tiempo_ultimo_ataque = 0.0

func on_enter():
	print("Estado: Atacando!")
	# Reiniciar el cronómetro de ataque al entrar para atacar inmediatamente
	tiempo_ultimo_ataque = father.intervalo_ataque 

func state_process(delta: float) -> void:
	# Lógica de daño periódico
	tiempo_ultimo_ataque += delta
	
	if tiempo_ultimo_ataque >= father.intervalo_ataque:
		atacar_base()
		tiempo_ultimo_ataque = 0.0
	
	# Comprobar si la base aún existe
	var base = GlobalPosicionSpawneo.base_aliada_nodo
	if not is_instance_valid(base):
		#next_state = estado_andar
		return
func atacar_base():
	var base = GlobalPosicionSpawneo.base_aliada_nodo
	if is_instance_valid(base):
		base.recibir_daño(father.daño)
	else:
		# Si la base ya no existe, volvemos a caminar (o lo que corresponda)
		#next_state = estado_andar
		return
func on_exit():
	pass
