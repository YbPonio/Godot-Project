extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int)

@export var health_value : float = 20 :
	get:
		return health_value
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health_value)
		
		health_value = value

func hit(damage : int):
	health_value -= damage
	
	emit_signal("on_hit", get_parent(), damage)
	
	if(health_value <= 0):
		get_parent().queue_free() 
