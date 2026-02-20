extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"

# Definir los estados a los que puede cambiar
@export var estado_atacar:State
const RANGO_ATAQUE = 150.0 # Distancia para dejar de caminar e iniciar ataque

func on_enter():
	print("Estado: Caminando hacia el objetivo")
	# Aquí podrías poner: animation_player.play("walk")

func state_process(delta: float) -> void:
	# Ejecutamos el movimiento del padre
	father.movimiento_enemigo1(delta)
	
	# Comprobar si hemos llegado a la posición de la base (Solo eje X)
	if father.posicion_base_aliada != null:
		var distancia_x = abs(father.global_position.x - father.posicion_base_aliada.x)
		
		# Log opcional para ver la distancia en consola (puedes borrarlo luego)
		# print("Distancia X a la base: ", distancia_x)
		
		if distancia_x <= 15.0: # Si estamos a 15px de distancia horizontal
			next_state = estado_atacar

func on_exit():
	pass
