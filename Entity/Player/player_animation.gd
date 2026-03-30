extends Node

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

var last_facing_direction = Vector2.RIGHT.x

func _process(delta: float) -> void:
	var state = player.state
	var shooting_dir = Vector2.ZERO.x
	var idle := !player.velocity.x
	
	if !idle:
		last_facing_direction = player.velocity.normalized().x
	
	if state in [player.STATES.IDLESHOOT, player.STATES.RUNSHOOT, player.STATES.JUMPSHOOT]:
		if player.firing_direction in [player.FIRING_DIRECTIONS.UP_LEFT, player.FIRING_DIRECTIONS.LEFT, player.FIRING_DIRECTIONS.DOWN_LEFT]:
			shooting_dir = Vector2.LEFT.x
		elif player.firing_direction in [player.FIRING_DIRECTIONS.UP_RIGHT, player.FIRING_DIRECTIONS.RIGHT, player.FIRING_DIRECTIONS.DOWN_RIGHT]:
			shooting_dir = Vector2.RIGHT.x
	
	match state:
		player.STATES.IDLE:
				animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
		player.STATES.IDLESHOOT:
				animation_tree.set("parameters/Idle_Shoot_StateMachine/Shoot_Down_Side/blend_position", shooting_dir)
				animation_tree.set("parameters/Idle_Shoot_StateMachine/Shoot_Side/blend_position", shooting_dir)
				animation_tree.set("parameters/Idle_Shoot_StateMachine/Shoot_Up_side/blend_position", shooting_dir)
				animation_tree.set("parameters/Idle_Shoot_StateMachine/Shoot_Down/blend_position", shooting_dir)
				animation_tree.set("parameters/Idle_Shoot_StateMachine/Shoot_Up/blend_position", shooting_dir)
		player.STATES.RUN:
			animation_tree.set("parameters/Run/blend_position", last_facing_direction)
		player.STATES.JUMP:
			animation_tree.set("parameters/Jump/blend_position", last_facing_direction)
		player.STATES.FALL:
			animation_tree.set("parameters/Fall/blend_position", last_facing_direction)
		player.STATES.RUNSHOOT:
			animation_tree.set("parameters/Run_Shoot_StateMachine/Shoot_Side/blend_position", last_facing_direction)
			animation_tree.set("parameters/Run_Shoot_StateMachine/Shoot_Side/0/blend_position", shooting_dir)
			animation_tree.set("parameters/Run_Shoot_StateMachine/Shoot_Side/1/blend_position", shooting_dir)
		player.STATES.JUMPSHOOT:
			pass
		player.STATES.SLIDE:
			pass
	
	#var debugRoot = animation_tree.get("parameters/playback")
	
	#debugRoot.travel("Idle_Shoot_StateMachine")
