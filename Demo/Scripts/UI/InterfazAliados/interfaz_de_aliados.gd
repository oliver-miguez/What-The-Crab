extends Control
class_name InterfazDeAliados

var instancia_aliado1 = preload("res://Demo/Escenas/Aliados/Aliado1.tscn")

func _on_aliado_1_pressed() -> void:
	var aliado1 = instancia_aliado1.instantiate()
	var mapa_actual = get_tree().current_scene
	var contenedor_aliados = mapa_actual.get_node("AliadosInstanciados")
	
	contenedor_aliados.add_child(aliado1)
	aliado1.global_position = GlobalPosicionSpawneo.posicion_spawneo
