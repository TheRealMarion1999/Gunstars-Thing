extends Node

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

var last_facing_direction = Vector2.RIGHT.x

func _process(delta: float) -> void:
	var state = player.state
	var shooting_dir = player.firing_direction
	var idle := !player.velocity.x
	
	if !idle:
		last_facing_direction = player.velocity.normalized().x
	
	match state:
		player.STATES.IDLE:
			pass
	
	match shooting_dir:
		pass
	
	var debugRoot = animation_tree.get("parameters/playback")
	
	#debugRoot.travel("Idle_Shoot_StateMachine")
	
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/Jump/blend_position", last_facing_direction)
	animation_tree.set("parameters/Fall/blend_position", last_facing_direction)
