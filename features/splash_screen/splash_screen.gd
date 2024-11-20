class_name SplashScreen extends Control

@export var splash_screens_container : Node
@export var in_time_sec : float = 0.5
@export var fade_in_time_sec : float = 1.5
@export var pause_time_sec : float = 1.5
@export var fade_out_time_sec : float = 1.5
@export var out_time_sec : float = 0.5
@export var load_ui_scene : PackedScene
@export var load_world_scene : PackedScene

var splash_screens : Array
var _tween : Tween

func _ready() -> void:
	get_screens()
	fade()
	

func fade() -> void:
	for i in len(splash_screens):
		_tween = self.create_tween()

		if i > 0:
			splash_screens[i].modulate.a = 0.0
			_tween.tween_interval(in_time_sec)
			_tween.tween_property(splash_screens[i], "modulate:a", 1.0, fade_in_time_sec)
		
		_tween.tween_interval(pause_time_sec)

		if (i < len(splash_screens) - 1):
			_tween.tween_property(splash_screens[i], "modulate:a", 0.0, fade_out_time_sec)
			_tween.tween_interval(out_time_sec)
		
		await _tween.finished
	
	ServiceLocator.scene_transition_service.set_next_world(load_world_scene).set_next_ui(load_ui_scene).transit()

func get_screens() -> void:
	splash_screens = splash_screens_container.get_children()

	for i in len(splash_screens):
		splash_screens[i].modulate.a = 1.0 if i == 0 else 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		ServiceLocator.scene_transition_service.set_next_world(load_world_scene).set_next_ui(load_ui_scene).transit()
		_tween.kill()
