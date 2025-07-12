extends CharacterBody3D

@onready var head = $Head
@onready var camera = $Head/Camera3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sense: float = 0.002
var def_speed: float = 4.0
var jump_speed: float = 2.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sense)
		camera.rotate_x(-event.relative.y * mouse_sense)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
	var current_gravity = gravity * delta
	
	if is_on_floor():
		velocity.y = -0.01
	else:
		velocity.y -= current_gravity
	
	if Input.is_action_just_pressed("moveJump") and is_on_floor():
		velocity.y = jump_speed
	
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveBackward", "moveForward")
	var direction = Vector3.ZERO
	if input_dir.length() > 0:
		direction = (transform.basis.z * -input_dir.y) + (transform.basis.x * input_dir.x)
		direction = direction.normalized()
	var rn_speed = def_speed * delta * 60
	
	if direction:
		velocity.x = direction.x * rn_speed
		velocity.z = direction.z * rn_speed
	else:
		velocity.x = move_toward(velocity.x, 0, rn_speed)
		velocity.z = move_toward(velocity.z, 0, rn_speed)

	move_and_slide()
