extends Area2D
class_name Bullet_Base

@export var bullet_type: Bullet

var fired_by_player = false

func init(player_fire:bool, bullet = bullet_type) -> void:
	fired_by_player = player_fire
	bullet_type = bullet

func _ready() -> void:
	$DestroyTimer.start()

func _process(delta: float) -> void:
	position += transform.x * bullet_type.speed * delta

##Destroy the bullet
func destroy() -> void:
	self.queue_free()


func _on_destroy_timer_timeout() -> void:
	destroy()

func copy_data_from_resource():
	if bullet_type.sprite == null:
		push_error("Missing Sprite in" + str(get_rid()))
	elif bullet_type.hitbox == null:
		push_error("Missing hitbox in" + str(get_rid()))
		return
	$DestroyTimer.wait_time = bullet_type.time_until_destroyed
	$Graphic.texture = bullet_type.sprite
	$HitBox.shape = bullet_type.hitbox

func load_data_from_gun_resource(gun: Gun):
	match gun.current_level:
		gun.GUN_LEVEL.LEVEL_1:
			bullet_type = gun.fires[gun.GUN_LEVEL.LEVEL_1]
		gun.GUN_LEVEL.LEVEL_2:
			bullet_type = gun.fires[gun.GUN_LEVEL.LEVEL_2]
		gun.GUN_LEVEL.LEVEL_3:
			bullet_type = gun.fires[gun.GUN_LEVEL.LEVEL_3]
	copy_data_from_resource()
