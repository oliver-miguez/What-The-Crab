extends Node2D
class_name BaseAliada

@onready var vida: Label = $Vida

@export var vida_maxima = 1000
var vida_actual = 1000

func _ready() -> void:
	vida.text = str(vida_actual)
	vida_actual = vida_maxima
	# Registramos el nodo completo en el global para que los enemigos puedan acceder a sus funciones
	GlobalPosicionSpawneo.base_aliada_nodo = self

func _physics_process(_delta: float) -> void:
	vida.text = str(vida_actual)


func recibir_daño(cantidad: int):
	vida_actual -= cantidad
	print("Base Enemiga recibió ", cantidad, " de daño. Vida restante: ", vida_actual)
	
	if vida_actual <= 0:
		morir()

func morir():
	print("¡La base enemiga ha sido destruida!")
	# Aquí podrías poner animaciones de explosión, cambiar de escena, etc.
	queue_free()

func _on_deteccion_aliados_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		print("Un enemigo está atacando la base")

func _on_deteccion_aliados_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		print("Un enemigo ha dejado de atacar")
