class_name SceneTransitionService extends Object

enum CleanType {DELETE, KEEP_RUNNING, REMOVE}

var transition_screen_handler: TransitionScreenHandler
var world : Node2D
var ui : Control

var _current_ui: Control


func change(new_scene: String, type: CleanType = CleanType.DELETE) -> void:
	if _current_ui != null:
		match type:
			CleanType.DELETE:
				_current_ui.queue_free()
			
			CleanType.KEEP_RUNNING:
				_current_ui.visible = false
			
			CleanType.REMOVE:
				ui.remove_child(_current_ui)

	var new = load(new_scene).instantiate()
	ui.add_child(new)
	_current_ui = new


func transit(new_scene: String, type: CleanType = CleanType.DELETE) -> void:
	if transition_screen_handler:
		await transition_screen_handler.invoke()
	
	change(new_scene, type)
	
	if  transition_screen_handler:
		transition_screen_handler.invoke(true)
