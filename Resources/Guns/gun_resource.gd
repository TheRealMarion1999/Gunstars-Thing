extends Resource
class_name Gun

enum GUN_LEVEL {
	LEVEL_1,
	LEVEL_2,
	LEVEL_3
}

@export var sprite: Texture2D

@export_enum("straight", "spread") var firing_type

@export var fires: Dictionary[GUN_LEVEL, Bullet]

@export var fire_rate: float = 0.05

@export var level_up_thresholds: Dictionary[GUN_LEVEL, int]

var gun_exp = 0
var current_level = GUN_LEVEL.LEVEL_1

@export var spread: int = 0

@export var gun_exp_lost_on_hit: int = 0

@export var name: String = "name"

@export var fire_refraction: float = 1.0
@export var recoils_in_air: bool = false
@export var recoil_total: float = 1.0

func check_for_level_change():
	pass
