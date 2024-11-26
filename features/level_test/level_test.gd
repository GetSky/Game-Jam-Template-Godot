extends Node2D

@export var pause: PackedScene

@onready var music_service: BackgroundMusicService = Injector.inject(BackgroundMusicService)
@onready var scene_service: SceneTransitionService = Injector.inject(SceneTransitionService)

var _paused : bool


func _ready() -> void:
	music_service.play(music_service.MusicType.MAIN)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if _paused == true:
			scene_service.set_next_ui(null).change()
		else:
			scene_service.set_next_ui(pause).change()
		_paused = !_paused
