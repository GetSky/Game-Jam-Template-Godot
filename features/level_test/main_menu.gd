extends Control

@onready var music_service: BackgroundMusicService = Injector.inject(BackgroundMusicService)


func _ready() -> void:
		music_service.play(music_service.MusicType.MAIN)
