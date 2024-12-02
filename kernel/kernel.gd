class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene

@onready var uits: UITransitionService = Injector.provide(
	UITransitionService, 
	"root", 
	[self, ui],
	)

@onready var wts: WorldTransitionService = Injector.provide(
	WorldTransitionService, 
	"root", 
	[self, world],
	)

@onready var bms: BackgroundMusicService = Injector.provide(
	BackgroundMusicService, 
	"root", 
	[self],
	)

func _ready() -> void:
	uits.set_next(splash_screen).change()
	bms.play(bms.MusicType.SPLASH)
