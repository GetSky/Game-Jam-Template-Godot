class_name TransitionScreen extends Control

@export var animator : AnimationPlayer
@export var animation_name : String = "Fade Out"
@export var execution_time_ms: int = 1000

var _speed: float
var _appearance: bool = true


func _ready() -> void:
	if execution_time_ms <= 0:
		execution_time_ms = 1000
	_speed = 1 / (execution_time_ms / 1000.0)


func play(appearance: bool) -> void:
	if animator.is_playing():
		await animator.animation_finished
		if _appearance == appearance:
			return

	animator.play(animation_name, -1.0, (-1 if appearance else 1) * _speed, appearance)
	await animator.animation_finished
	_appearance = !_appearance
