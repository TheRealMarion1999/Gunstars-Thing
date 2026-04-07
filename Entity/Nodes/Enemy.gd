extends CharacterBody2D
class_name Enemy

enum DROPS {
	HEART,
	MISSLE,
	EXP
}

@export var HP: int
@export var detectRadius: Area2D
@export var max_velocity = 500
@export var flying = false

func _physics_process(delta: float) -> void:
	gravity(delta)
	move_and_slide()

func take_damage(damage: int):
	HP -= damage
	if HP <= 0:
		destroy()

func destroy():
	queue_free()

func gravity(delta):
	if !flying:
		if !is_on_floor():
			velocity += get_gravity() * delta
