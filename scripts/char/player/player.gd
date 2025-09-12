extends CharacterBody3D

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var inventory_ui = $Inventory

@export var mouse_sens: float = 0.002
@export var speed: float = 5.0
@export var jump_vel: float = 3.5
@export var accel: float = 6.0
@export var gravity = 9.8

var inventory_is_open: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * mouse_sens)
			camera.rotate_x(-event.relative.y * mouse_sens)
			camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))

	if event.is_action_pressed("inventory"):
		toggle_inventory()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta


	var input_dir = Vector3(0,0,0)
	var direction = Vector3()

	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_back")
	direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
 
	velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
	move_and_slide()

func toggle_inventory():
	inventory_is_open = !inventory_is_open
	
	if inventory_is_open:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		inventory_ui.show_inventory()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		inventory_ui.hide_inventory()
