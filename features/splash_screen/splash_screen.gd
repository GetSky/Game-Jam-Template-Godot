class_name SplashScreen extends Control

@export var in_time_sec : float = 0.5
@export var fade_in_time_sec : float = 1.5
@export var pause_time_sec : float = 1.5
@export var fade_out_time_sec : float = 1.5
@export var out_time_sec : float = 0.5
@export var load_ui_scene : PackedScene
@export var load_world_scene : PackedScene

@onready var sound = $BackgroundSound
@onready var splash_screens_container = $Splashes

@onready var ui_service: UITransitionService = Injector.inject(UITransitionService)
@onready var world_service: WorldTransitionService = Injector.inject(WorldTransitionService)

var splash_screens : Array
var _tween : Tween


func _ready() -> void:
	_get_screens()
	sound.play()
	fade()


func fade() -> void:
	for i in len(splash_screens):
		_tween = self.create_tween()

		if i > 0:
			splash_screens[i].modulate.a = 0.0
			_tween.tween_interval(in_time_sec)
			_tween.tween_callback(sound.play)
			_tween.tween_property(splash_screens[i], "modulate:a", 1.0, fade_in_time_sec)
		
		_tween.tween_interval(pause_time_sec)
		
		if (i < len(splash_screens) - 1):
			_tween.tween_property(splash_screens[i], "modulate:a", 0.0, fade_out_time_sec)
			_tween.tween_interval(out_time_sec)
		
		await _tween.finished
	
	world_service.set_next(load_world_scene).transit()
	ui_service.set_next(load_ui_scene).transit()


func _get_screens() -> void:
	splash_screens = splash_screens_container.get_children()
	for i in len(splash_screens):
		splash_screens[i].modulate.a = 1.0 if i == 0 else 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		world_service.set_next(load_world_scene).transit()
		ui_service.set_next(load_ui_scene).transit()
		_tween.kill()
