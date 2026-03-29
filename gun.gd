extends Node2D
class_name Gun_Base
##Guns fire bullet objects and store instructions on how to instantiate their bullets.
##Guns have a sprite
##Guns have a level, which increases and changes the properties of their bullets. All guns have three levels.
const BULLET = preload("res://bullet.tscn")

@export var blunch = 10

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if $FireTimer.is_stopped():
			$FireTimer.start()
			var bullet = BULLET.instantiate()
			get_tree().root.add_child(bullet)
			bullet.global_position = global_position
			bullet.global_rotation = global_rotation
	
