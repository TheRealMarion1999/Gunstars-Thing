extends RigidBody2D
class_name exp_piece

enum PIECE_SIZE {
	SMALL,
	MEDIUM,
	BIG
}

##TODO: exp should only bounce on floors, walls and ceilings

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.current_gun.gun_exp += 1
		queue_free()

func _on_destroy_timer_timeout() -> void:
	queue_free()
