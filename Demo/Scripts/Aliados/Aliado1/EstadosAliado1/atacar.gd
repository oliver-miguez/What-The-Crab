extends "res://Demo/Scripts/Globales/Estados/GlobalState.gd"

# Definir los estados a los que puede cambiar
@export var estado_andar:State
const RANGO_PERDIDA = 180.0 # Un poco más que el de ataque para evitar rebotes de estado

func on_enter():
	print("Estado: Atacando!")
	# Aquí podrías poner: animation_player.play("attack")

func state_process(_delta: float) -> void:
	# Aquí iría la lógica de daño a la base (temporizadores, animaciones, etc.)
	# Como es una base estática, no necesitamos volver a caminar a menos que 
	# el objetivo cambie o sea destruido.
	pass

func on_exit():
	pass
