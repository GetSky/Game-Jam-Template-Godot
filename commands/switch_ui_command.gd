class_name SwitchUICommand extends Injectable

var _service: UITransitionService 

func _init(s: UITransitionService) -> void:
	_service = s

func invoke(ui: PackedScene) -> void:
	_service.change(ui, _service.CleanType.KEEP_RUNNING)
