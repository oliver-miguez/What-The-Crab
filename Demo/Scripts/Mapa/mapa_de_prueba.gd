extends Node2D
class_name MapaDePrueba

@onready var punto_spawneo_aliados: Marker2D = $SpawnAliados/PuntoSpawneoAliados
@onready var posicion_base_enemiga: Marker2D = $SpawnAliados/PosicionBaseEnemiga

func _ready() -> void:
	GlobalPosicionSpawneo.posicion_spawneo = punto_spawneo_aliados.global_position
	GlobalPosicionSpawneo.posicion_base_enemiga = posicion_base_enemiga.position
	
func _physics_process(_delta: float) -> void:
	pass
