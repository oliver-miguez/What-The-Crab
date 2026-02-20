extends Node2D
class_name MapaDePrueba

@onready var punto_spawneo_enemigos: Marker2D = $SpawnAliados/PuntoSpawneoEnemigos
@onready var punto_spawneo_aliados: Marker2D = $SpawnAliados/PuntoSpawneoAliados
@onready var posicion_base_enemiga: Marker2D = $SpawnAliados/PosicionBaseEnemiga
@onready var posicion_base_aliada: Marker2D = $SpawnAliados/PosicionBaseAliada

func _ready() -> void:
	GlobalPosicionSpawneo.posicion_spawneo_enemigos = punto_spawneo_enemigos.global_position
	GlobalPosicionSpawneo.posicion_spawneo = punto_spawneo_aliados.global_position
	GlobalPosicionSpawneo.posicion_base_enemiga = posicion_base_enemiga.global_position
	GlobalPosicionSpawneo.posicion_base_aliada = posicion_base_aliada.global_position
	
func _physics_process(_delta: float) -> void:
	pass
