extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var dead_animation_name : String = "death"
@export var health_value : float = 20 :
	get:
		return health_value
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health_value)
		
		health_value = value

func hit(damage : int, knockback_direction : Vector2):
	health_value -= damage
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
