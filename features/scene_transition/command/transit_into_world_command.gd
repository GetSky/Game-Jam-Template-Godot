class_name TransitIntoWorldCommand extends Injectable

var _world_service: WorldTransitionService
var _ui_service: UITransitionService
var _curtain: Curtain


func _init(w: WorldTransitionService, ui: UITransitionService, c: Curtain = null) -> void:
	_world_service = w
	_ui_service = ui
	_curtain = c


func invoke(world: PackedScene, ui: PackedScene = null) -> void:
	if _curtain:
		await _curtain.play(false)

	_world_service.change(world)
	_ui_service.change(ui)
	
	if  _curtain:
		_curtain.play(true)
