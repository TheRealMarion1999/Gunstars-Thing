extends Resource
class_name Bullet

@export var sprite: Texture2D
@export var speed: int = 500
@export var hitbox: Shape2D
@export var damage: int = 2
@export var time_until_destroyed: float = 1.0
@export var turns_into: Bullet

var fired_by_player: bool = false
