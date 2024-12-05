class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene
@export var transition_screen: TransitionScreen

var _bms : BackgroundMusicService
var _open_ui : OpenUICommand

func _ready() -> void:
	_init()
	_run()

func _init() -> void:
	_bms = Injector.provide(BackgroundMusicService, "root", [self])

	var uits = Injector.provide(UITransitionService, self, [ui, transition_screen])
	var wts = Injector.provide(WorldTransitionService, self, [world, transition_screen])

	_open_ui = Injector.provide(OpenUICommand, "root", [uits])
	Injector.provide(SwitchUICommand, "root", [uits])
	Injector.provide(TransitIntoWorldCommand, "root", [wts, uits])

func _run()-> void:
	_open_ui.invoke(splash_screen)
	_bms.play(_bms.MusicType.SPLASH)
