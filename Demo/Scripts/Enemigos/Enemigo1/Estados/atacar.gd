extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"
class_name AtacarEnemigo

# Definir los estados a los que puede cambiar
@export var estado_andar:State
const RANGO_BASE = 50.0

var tiempo_ultimo_ataque = 0.0

func on_enter():
	print("[Enemigos] Estado: Atacando!")
	# Si tienes animación de ataque para el enemigo, actívala aquí
	# animation_player.play("ataque")
	tiempo_ultimo_ataque = 0.0
	
func state_process(delta: float) -> void:
	tiempo_ultimo_ataque += delta

	# 1. Lógica de DAÑO
	if tiempo_ultimo_ataque >= father.intervalo_ataque:
		var atacado = false
		
		if is_instance_valid(father.objetivo_actual):
			father.objetivo_actual.recibir_daño(father.daño)
			atacado = true
		else:
			var base = GlobalPosicionSpawneo.base_aliada_nodo
			if is_instance_valid(base):
				var distancia_x = abs(father.global_position.x - base.global_position.x)
				if distancia_x <= RANGO_BASE:
					base.recibir_daño(father.daño)
					atacado = true

		if atacado:
			tiempo_ultimo_ataque = 0.0

	# 2. Lógica de SALIDA
	var debe_seguir_atacando = false
	
	if is_instance_valid(father.objetivo_actual):
		debe_seguir_atacando = true
	else:
		var base = GlobalPosicionSpawneo.base_aliada_nodo
		if is_instance_valid(base):
			var distancia_x = abs(father.global_position.x - base.global_position.x)
			if distancia_x <= RANGO_BASE:
				debe_seguir_atacando = true
	
	if not debe_seguir_atacando:
		next_state = estado_andar

func on_exit():
	pass
