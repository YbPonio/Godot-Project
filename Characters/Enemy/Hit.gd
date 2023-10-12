extends State

class_name HitState

@export var damageable : Damageable

func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_damageable_hit():
	pass
