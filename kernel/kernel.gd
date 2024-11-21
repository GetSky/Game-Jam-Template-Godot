class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var splash_screen : PackedScene

@onready var sts: SceneTransitionService = Injector.provide(
	SceneTransitionService, 
	"root", 
	[world, ui],
	)

func _ready() -> void:
	sts.set_next_ui(splash_screen).change()
