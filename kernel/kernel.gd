class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene
@export var transition_screen: TransitionScreen

@onready var uits: UITransitionService = Injector.provide(
	UITransitionService, 
	"root", 
	[ui, transition_screen],
	)

@onready var wts: WorldTransitionService = Injector.provide(
	WorldTransitionService, 
	"root", 
	[world, transition_screen],
	)

@onready var bms: BackgroundMusicService = Injector.provide(
	BackgroundMusicService, 
	"root", 
	[self],
	)

func _ready() -> void:
	uits.change(splash_screen)
	bms.play(bms.MusicType.SPLASH)
