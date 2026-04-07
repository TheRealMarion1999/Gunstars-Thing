extends Node2D
class_name Gun_Base
##Guns fire bullet objects and store instructions on how to instantiate their bullets.
##Guns have a sprite
##Guns have a level, which increases and changes the properties of their bullets. All guns have three levels.
const BULLET = preload("res://Resources/Bullets/bullet_base.tscn")
@export var gun_data: Gun

@onready var player: Player = get_owner()

var spread: int = 0

func _ready() -> void:
	get_data_from_resource()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if $FireTimer.is_stopped():
			$FireTimer.start()
			var bullet = BULLET.instantiate()
			bullet.is_fired_by_player = true
			bullet.load_data_from_gun_resource(gun_data)
			get_tree().root.add_child(bullet)
			bullet.global_position = global_position
			bullet.global_rotation_degrees = global_rotation_degrees + randi_range(-spread, spread)
	

func get_data_from_resource():
	$FireTimer.wait_time = gun_data.fire_rate
	$Sprite.texture = gun_data.sprite
	spread = gun_data.spread
