extends CanvasLayer

@onready var panel = $Panel

func _ready():
    hide_inventory()

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("inventory"):
        toggle_inventory()

func show_inventory():
    panel.visible = true
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func hide_inventory():
    panel.visible = false
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func toggle_inventory():
    if panel.visible:
        hide_inventory()
    else:
        show_inventory()