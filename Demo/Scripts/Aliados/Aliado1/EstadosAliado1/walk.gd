extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"
class_name AndarAliado

@export var estado_atacar:State
const RANGO_DETECCION_BASE = 50.0 # Rango para pasar de caminar a atacar

func on_enter():
	print("[Aliados] Caminando")
	animation_player.play("caminar")
	
func state_process(delta: float) -> void:
	# Ejecutamos el movimiento del padre
	father.movimiento_aliado1(delta)
	
	# Prioridad: Enemigo detectado
	if is_instance_valid(father.objetivo_actual):
		next_state = estado_atacar
		return
		
	# Comprobar si hemos llegado a la base
	var base = GlobalPosicionSpawneo.base_enemiga_nodo
	if is_instance_valid(base):
		var distancia_x = abs(father.global_position.x - base.global_position.x)
		if distancia_x <= RANGO_DETECCION_BASE:
			next_state = estado_atacar

func on_exit():
	pass
