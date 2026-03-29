extends Area2D

@export var sprite: SpriteFrames
@export var speed: int = 500
@export var damage: int = 2
@export var turns_into: Bullet

var fired_by_player = false

func init(player_fire:bool) -> void:
	fired_by_player = player_fire

func _ready() -> void:
	$DestroyTimer.start()

func _process(delta: float) -> void:
	position += transform.x * speed * delta

##Destroy the bullet
func destroy() -> void:
	self.queue_free()


func _on_destroy_timer_timeout() -> void:
	destroy()
