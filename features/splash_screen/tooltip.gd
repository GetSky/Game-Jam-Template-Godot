extends Label

@export var time_sec : float = 0.4
@export var alpha_fade_in : float = 0.2
@export var alpha_fade_out : float = 1.0

func _ready() -> void:
	var tween = self.create_tween().set_loops()
	tween.tween_property(self, "modulate:a", alpha_fade_in, time_sec)
	tween.tween_property(self, "modulate:a", 1.0, time_sec)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		self.visible = false
