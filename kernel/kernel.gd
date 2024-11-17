class_name Kernel extends Node

@export var world : Node2D
@export var ui : Control
@export var transition_screen_handler : TransitionScreenHandler
@export var splash_screen : Resource

func _ready() -> void:
	init()
	ServiceLocator.scene_transition_service.change(splash_screen.resource_path)

func init() -> void:
	var service = SceneTransitionService.new()
	service.transition_screen_handler = transition_screen_handler
	service.world = world
	service.ui = ui
	ServiceLocator.scene_transition_service = service
