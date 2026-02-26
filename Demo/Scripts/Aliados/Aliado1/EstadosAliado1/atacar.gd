extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"
class_name AtacarAliado

@export var estado_andar:State
var tiempo_ultimo_ataque = 0.0

func on_enter():
	print("[Aliados] Entrando en ataque")
	animation_player.play("ataque")
	tiempo_ultimo_ataque = 0.0 

func state_process(delta: float) -> void:
	tiempo_ultimo_ataque += delta

	if tiempo_ultimo_ataque >= father.intervalo_ataque:
		var atacado = false
		
		# Prioridad 1: Enemigos
		if is_instance_valid(father.objetivo_actual):
			father.objetivo_actual.recibir_daño(father.daño)
			atacado = true
		# Prioridad 2: Base (Si estamos cerca)
		else:
			var base = GlobalPosicionSpawneo.base_enemiga_nodo
			if is_instance_valid(base):
				var dist = abs(father.global_position.x - base.global_position.x)
				if dist <= 60.0: # Rango generoso para el ataque
					base.recibir_daño(father.daño)
					atacado = true
		
		if atacado:
			tiempo_ultimo_ataque = 0.0

	# Lógica de salida: ¿Sigue habiendo algo que atacar?
	var hay_enemigo = is_instance_valid(father.objetivo_actual)
	var hay_base = false
	var base = GlobalPosicionSpawneo.base_enemiga_nodo
	if is_instance_valid(base):
		if abs(father.global_position.x - base.global_position.x) <= 60.0:
			hay_base = true
	
	if not hay_enemigo and not hay_base:
		next_state = estado_andar

func on_exit():
	pass
