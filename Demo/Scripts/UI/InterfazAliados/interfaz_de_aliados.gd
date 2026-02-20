extends Control
class_name InterfazDeAliados

var instancia_aliado1 = preload("res://Demo/Escenas/Aliados/Aliado1.tscn")
var instancia_enemigo1 = preload("res://Demo/Escenas/Enemigos/Enemigo1/Enemigo_1.tscn")

func _on_aliado_1_pressed() -> void:
	var aliado1 = instancia_aliado1.instantiate()
	var mapa_actual = get_tree().current_scene
	var contenedor_aliados = mapa_actual.get_node("AliadosInstanciados")
	
	contenedor_aliados.add_child(aliado1)
	aliado1.global_position = GlobalPosicionSpawneo.posicion_spawneo


func _on_enemigo_1_pressed() -> void:
	var enemigo1 = instancia_enemigo1.instantiate()
	var mapa_actual = get_tree().current_scene
	var contenedor_enemigos = mapa_actual.get_node("EnemigosInstanciados")
	
	contenedor_enemigos.add_child(enemigo1)
	enemigo1.global_position = GlobalPosicionSpawneo.posicion_spawneo_enemigos
