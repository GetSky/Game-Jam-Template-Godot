extends Node2D

@export var pause: PackedScene

@onready var music_service: BackgroundMusicService = Injector.inject(BackgroundMusicService)
@onready var scene_service: UITransitionService = Injector.inject(UITransitionService)

var _paused : bool


func _ready() -> void:
	music_service.play(music_service.MusicType.MAIN)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if _paused == true:
			scene_service.change(null, scene_service.CleanType.REMOVE)
		else:
			scene_service.change(pause)
		_paused = !_paused
