class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene
@export var curtain: Curtain

var _bms : BackgroundMusicService
var _open_ui : OpenUICommand

func _ready() -> void:
	_resolve_dependencies()
	_run()

func _resolve_dependencies() -> void:
	_bms = Injector.provide(BackgroundMusicService, "root", [self])

	var uits = Injector.provide(UITransitionService, "root", [ui])
	var wts = Injector.provide(WorldTransitionService, "root", [world])

	_open_ui = Injector.provide(OpenUICommand, "root", [uits])
	Injector.provide(SwitchUICommand, "root", [uits])
	Injector.provide(TransitIntoWorldCommand, "root", [wts, uits, curtain])

func _run()-> void:
	_open_ui.invoke(splash_screen)
	_bms.play(_bms.MusicType.SPLASH)
