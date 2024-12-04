class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene
@export var transition_screen: TransitionScreen

@onready var uits: UITransitionService = Injector.provide(
	UITransitionService, 
	self, 
	[ui, transition_screen],
	)

@onready var wts: WorldTransitionService = Injector.provide(
	WorldTransitionService, 
	self, 
	[world, transition_screen],
	)

@onready var bms: BackgroundMusicService = Injector.provide(
	BackgroundMusicService, 
	"root", 
	[self],
	)

@onready var ouic = Injector.provide(OpenUICommand, "root", [uits])
@onready var suic = Injector.provide(SwitchUICommand, "root", [uits])
@onready var owuic = Injector.provide(TransitIntoWorldCommand, "root", [wts, uits])

func _ready() -> void:
	ouic.invoke(splash_screen)
	bms.play(bms.MusicType.SPLASH)
