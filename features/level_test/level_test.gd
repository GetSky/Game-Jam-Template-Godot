extends Node2D

@export var pause: PackedScene
@export var next: PackedScene

@onready var music_service: BackgroundMusicService = Injector.inject(BackgroundMusicService)
@onready var switch_ui = Injector.inject(SwitchUICommand)
@onready var switch = Injector.inject(TransitIntoWorldCommand)

var _paused : bool


func _ready() -> void:
	music_service.play(music_service.MusicType.MAIN)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Next"):
		switch.invoke(next)
	
	if event.is_action_pressed("Pause"):
		if _paused:
			switch_ui.invoke(null)
		else:
			switch_ui.invoke(pause)
		_paused = !_paused
