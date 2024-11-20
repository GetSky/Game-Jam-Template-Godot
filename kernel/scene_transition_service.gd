class_name SceneTransitionService extends Object

enum CleanType {DELETE, KEEP_RUNNING, REMOVE}

var transition_screen_handler: TransitionScreenHandler
var world : Node2D
var ui : Control

var _next_ui: PackedScene
var _next_world: PackedScene

var _current_ui: Control
var _current_world: Node2D


func set_next_ui(new_ui: PackedScene) -> Object:
	_next_ui = new_ui
	return self


func set_next_world(new_world: PackedScene) -> Object:
	_next_world = new_world
	return self


func change(type: CleanType = CleanType.DELETE) -> void:
	if _isEqual(_current_ui, _next_ui) == false:
		_change_ui(type)
		
	if _isEqual(_current_world, _next_world) == false:
		_change_world(type)


func transit(type: CleanType = CleanType.DELETE) -> void:
	if transition_screen_handler:
		await transition_screen_handler.invoke()
	
	change(type)
	await transition_screen_handler.get_tree().create_timer(1).timeout
	
	if  transition_screen_handler:
		transition_screen_handler.invoke(true)


func _change_ui(type: CleanType) -> void:
	_clear(_current_ui, ui, type)
	_current_ui = _create(_next_ui, ui)
	_next_ui = null


func _change_world(type: CleanType) -> void:
	_clear(_current_world, world, type)
	_current_world = _create(_next_world, world)
	_next_world = null


func _clear(target: Node, root: Node, type: CleanType) -> void:
	if target == null: 
		return

	match type:
		CleanType.DELETE:
			target.queue_free()

		CleanType.KEEP_RUNNING:
			target.visible = false
			
		CleanType.REMOVE:
			root.remove_child(target)


func _create(scene: PackedScene, to: Node) -> Node:
	var new = null
	if scene != null:
		new = scene.instantiate()
		to.add_child(new)
	return new


func _isEqual(a, b):
	if (a != null && a.get_script()!=null && b != null && b.get_script()!=null):
		if (a.get_script().resource_path == b.get_script().resource_path):
			return true
		
	return false	
