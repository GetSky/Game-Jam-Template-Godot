class_name CurtainService extends Injectable

var _curtain: Curtain

func _init(curtain: Curtain):
	_curtain = curtain

func drop() -> void:
	await _curtain.play(false)

func hide() -> void:
	await _curtain.play(true)
