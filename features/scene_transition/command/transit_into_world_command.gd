class_name TransitIntoWorldCommand extends Injectable

var _world_service: WorldTransitionService
var _ui_service: UITransitionService


func _init(w: WorldTransitionService, ui: UITransitionService) -> void:
	_world_service = w
	_ui_service = ui


func invoke(world: PackedScene, ui: PackedScene = null) -> void:
	_world_service.transit(world)
	_ui_service.transit(ui)
