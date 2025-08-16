extends CharacterBody3D

@onready var head = $Head
@onready var camera = $Head/Camera3D

@export var mouse_sens: float = 0.002
@export var speed: float = 5.0
@export var jump_vel: float = 3.5
var rotation_x: float = 0. #govnokod

var gravity = 9.8

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event): #govnokod
    if event is InputEventMouseMotion:
        rotate_y(-event.relative.x * mouse_sens)
        rotation_x -= event.relative.y * mouse_sens
        rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
        head.rotation.x = rotation_x # fix

func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta
    if Input.is_action_just_pressed("move_jump") and is_on_floor():
        velocity.y = jump_vel

    var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if is_on_floor():
        if direction:
            velocity.x = direction.x * speed
            velocity.z = direction.z * speed
        else:
            velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
            velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
    else:
        velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
        velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
    
    move_and_slide()