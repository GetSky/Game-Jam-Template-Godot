class_name TransitionScreen extends Control

@export var animator : AnimationPlayer
@export var execution_time_ms: int = 1000

var _speed: float


func _ready() -> void:
	if execution_time_ms <= 0:
		execution_time_ms = 1000
	_speed = 1 / (execution_time_ms / 1000.0)


func invoke(is_backward: bool = false) -> void:
	if is_backward == false:
		animator.play("Fade Out", -1.0, _speed)
	else:
		animator.play("Fade Out", -1.0, -_speed, true)
	
	await animator.animation_finished
