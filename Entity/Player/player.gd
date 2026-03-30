extends CharacterBody2D
class_name Player

enum STATES {
	IDLE,
	IDLESHOOT,
	RUN,
	RUNSHOOT,
	JUMP,
	JUMPSHOOT,
	FALL,
	SLIDE,
	KNIFE,
}

enum FIRING_DIRECTIONS {
	UP,
	UP_LEFT,
	LEFT,
	DOWN_LEFT,
	DOWN,
	DOWN_RIGHT,
	RIGHT,
	UP_RIGHT
}
const FIRING_ANGLES = [22.5, 67.5, 112.5, 158.5, 202.5, 247.5, 292.5, 337.5]
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const JUMP_DESCENT = 8.333391
const KNIFE_FRAMES: float = 0.2

var hold_counter = 0.0
var state = STATES.IDLE
var firing_direction = FIRING_DIRECTIONS.RIGHT

#For some reaosn this ONLY works if it's done like this. Killing myself.
@onready var arm_rotate = $Rotation

##TODO: break all this up into individual functions.
func _physics_process(delta: float) -> void:
	$Rotation.look_at(get_global_mouse_position())
	rot_rollover()
	update_firing_direction(arm_rotate.rotation_degrees)
	
	
	var is_initiating_slide := is_on_floor() && Input.is_action_just_pressed("jump") && Input.is_action_pressed("ui_down")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			state = STATES.RUN
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			if state == STATES.FALL:
				print("landed")
			state = STATES.IDLE

	if Input.is_action_pressed("shoot"):
		if state in[STATES.IDLE, STATES.IDLESHOOT]:
			state = STATES.IDLESHOOT
		elif state in [STATES.RUN, STATES.RUNSHOOT]:
			state = STATES.RUNSHOOT

	jump()
	if is_initiating_slide:
		state = STATES.SLIDE
		print("slide")
	debug_state_indicator()
	debug_firing_direction()
	move_and_slide()


func jump():
	var is_initiating_jump := is_on_floor() && Input.is_action_pressed("jump")
	# Handle jump.
	if is_initiating_jump:
		if state in [STATES.IDLE, STATES.RUN, STATES.IDLESHOOT, STATES.RUNSHOOT]:
			state = STATES.JUMP
			velocity.y = JUMP_VELOCITY
	if velocity.y > 0:
		state = STATES.FALL

const ROT_MAX:float = 360
const ROT_MIN:float = 0

func rot_rollover():
	if arm_rotate.rotation_degrees >= ROT_MAX:
		arm_rotate.rotation_degrees = ROT_MIN
	elif arm_rotate.rotation_degrees <= ROT_MIN:
		arm_rotate.rotation_degrees = ROT_MAX

func update_firing_direction(arm_rotation):
	if arm_rotation >= FIRING_ANGLES[7] || arm_rotation <= FIRING_ANGLES[0]:
		firing_direction = FIRING_DIRECTIONS.RIGHT
	elif arm_rotation >= FIRING_ANGLES[0] && arm_rotation <= FIRING_ANGLES[1]:
		firing_direction = FIRING_DIRECTIONS.DOWN_RIGHT
	elif arm_rotation >= FIRING_ANGLES[1] && arm_rotation <= FIRING_ANGLES[2]:
		firing_direction = FIRING_DIRECTIONS.DOWN
	elif arm_rotation >= FIRING_ANGLES[2] && arm_rotation <= FIRING_ANGLES[3]:
		firing_direction = FIRING_DIRECTIONS.DOWN_LEFT
	elif arm_rotation >= FIRING_ANGLES[3] && arm_rotation <= FIRING_ANGLES[4]:
		firing_direction = FIRING_DIRECTIONS.LEFT
	elif arm_rotation >= FIRING_ANGLES[4] && arm_rotation <= FIRING_ANGLES[5]:
		firing_direction = FIRING_DIRECTIONS.UP_LEFT
	elif arm_rotation >= FIRING_ANGLES[5] && arm_rotation <= FIRING_ANGLES[6]:
		firing_direction = FIRING_DIRECTIONS.UP
	elif arm_rotation >= FIRING_ANGLES[6] && arm_rotation <= FIRING_ANGLES[7]:
		firing_direction = FIRING_DIRECTIONS.UP_RIGHT

func debug_state_indicator():
	match state:
		STATES.IDLE:
			$State_Indicator.text = "idle"
		STATES.RUN:
			$State_Indicator.text = "Run"
		STATES.JUMP:
			$State_Indicator.text = "Jump"
		STATES.FALL:
			$State_Indicator.text = "Fall"
		STATES.SLIDE:
			$State_Indicator.text = "Slide"
		STATES.IDLESHOOT:
			$State_Indicator.text = "Idle Shoot"
		STATES.RUNSHOOT:
			$State_Indicator.text = "Run Shoot"

func debug_firing_direction():
	match firing_direction:
		FIRING_DIRECTIONS.UP:
			$Fire_Direction.text = "Up"
		FIRING_DIRECTIONS.UP_LEFT:
			$Fire_Direction.text = "Up Left"
		FIRING_DIRECTIONS.LEFT:
			$Fire_Direction.text = "Left"
		FIRING_DIRECTIONS.DOWN_LEFT:
			$Fire_Direction.text = "Down Left"
		FIRING_DIRECTIONS.DOWN:
			$Fire_Direction.text = "Down"
		FIRING_DIRECTIONS.DOWN_RIGHT:
			$Fire_Direction.text = "Down Right"
		FIRING_DIRECTIONS.RIGHT:
			$Fire_Direction.text = "Right"
		FIRING_DIRECTIONS.UP_RIGHT:
			$Fire_Direction.text = "Up Right"
