extends CharacterBody2D
class_name Aliado1

@onready var vida_label: Label = $Vida

const GRAVITY_VALUE = 980
const SPEED_VALUE = 100

@export var daño = 10

# Un golpe cada 2 segundos
@export var intervalo_ataque = 2.0 

# Guardar un valor Vector2 sobre donde se encuentra la base enemiga
var posicion_base_enemiga

var velocidad_actual = Vector2.ZERO
var ultima_posicion = Vector2.ZERO

# Ajustes de la vida del player
var vida_maxima = 125
var vida_actual = 125

# Array que recoge a todos los enemigos que entran en el area del aliado
var objetivo_actual: Array[Enemigo1]
# Enemigo fijado o principal
var enemigo_fijado:Enemigo1

## Se ejecuta al inicio de la escena
func _ready() -> void:
	# Label de vida a mostrar en pantalla
	vida_label.text = str(vida_actual) 
	# Recoge la posición de la base enemiga del script global que la recoge del mapa
	posicion_base_enemiga = GlobalPosicionSpawneo.posicion_base_enemiga
	# Va recogiendo en que posición está el aliado
	ultima_posicion = global_position

## Se ejecuta cada frame del juego
func _physics_process(delta: float) -> void:
	# Actualizar constantemente la vida en pantalla
	vida_label.text = str(vida_actual)

	# Añade gravedad a los personajes
	if not is_on_floor():
		añadir_gravedad(delta)
	
	# Revisa constantemente cual es el enemigo al que se debe atacar
	actualizar_objetivo()
	
	# Permite el movimiento sobre las colisiones del mapa a los aliados
	move_and_slide()

## Permite quitar vida a los aliados
func recibir_daño(cantidad_daño:int):
	print("[Aliados]: Estoy recibiendo daño de los enemigos")
	# Quitar vida al aliado 
	vida_actual = vida_actual - cantidad_daño;
	# Si no tiene vida muere
	if vida_actual <= 0:
		morir()
		
## Elimina al aliado de la escena 
func morir():
	print("Un aliado ha muerto")
	# Elimina al aliado de la escena
	queue_free()

## Administra el funcionamiento del movimiento de los aliados
func movimiento_aliado1(delta):
	# Si se está encargando de algún enemigo
	if is_instance_valid(objetivo_actual):
		return
		
	# Mover hacia la base enemiga usando el nodo global
	var base = GlobalPosicionSpawneo.base_enemiga_nodo
	if is_instance_valid(base):
		var destino = base.global_position
		# Mantener la Y del aliado (para que no intente "volar" hacia el centro de la base si está en el suelo)
		destino.y = global_position.y 
		global_position = global_position.move_toward(destino, SPEED_VALUE * delta)
	
	velocidad_actual = (global_position - ultima_posicion) / delta
	ultima_posicion = global_position

## Administra la gravedad que le afecta a cada aliado
func añadir_gravedad(delta):
	position.y += GRAVITY_VALUE * delta
	
## Define cual es el primer enemigo al que se atacará
func actualizar_objetivo():
	if not objetivo_actual.is_empty():
		# Asigna prioridad a los enemigos  por orden del array para atacarlos por turnos
		enemigo_fijado = objetivo_actual[0]
		
func _on_area_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		print("[Aliados]:Estoy detectando un enemigo en mi area de deteccion")
		# Añade al o los enemigos a un array que los almacena
		objetivo_actual.append(body)
		
func _on_area_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		print("[Aliados]: El enemigo salió de mi area de detección, borrandolo del almacen de enemigos")
		# Elimina al enemigo que sale del area del aliado, liberando espacio en la lista 
		objetivo_actual.erase(body)
