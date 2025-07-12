extends CanvasLayer

@onready var frame_label = $FrameLabel

func _physics_process(delta: float) -> void:
	frame_label.set_text("FPS" + str(Engine.get_frames_per_second()))
