class_name SceneTransitionService extends Injectable

enum CleanType {DELETE, KEEP_RUNNING, REMOVE}


var _transition_screen: TransitionScreen
var _world : Node2D
var _ui : Control

var _last_ui: PackedScene
var _last_world: PackedScene
var _next_ui: PackedScene
var _next_world: PackedScene

var _current_ui: Control
var _current_world: Node2D

var _keep_scenes = {}


func _init(w: Node2D, u: Control):
	_world = w
	_ui = u
	_transition_screen = preload("transition_screen.tscn").instantiate()
	u.get_parent().add_child(_transition_screen, true)


func set_next_ui(new_ui: PackedScene) -> SceneTransitionService:
	_next_ui = new_ui
	return self


func set_next_world(new_world: PackedScene) -> SceneTransitionService:
	_next_world = new_world
	return self


func change(type: CleanType = CleanType.DELETE) -> void:
	if _isEqual(_last_ui, _next_ui) == false:
		_change_ui(type)
		
	if _isEqual(_last_world, _next_world) == false:
		_change_world(type)


func transit(type: CleanType = CleanType.DELETE) -> void:
	if _transition_screen:
		await _transition_screen.invoke()
	
	change(type)
	
	if  _transition_screen:
		_transition_screen.invoke(true)


func _change_ui(type: CleanType) -> void:
	_clear(_current_ui, _ui, type)
	_current_ui = _create(_next_ui, _ui)
	_last_ui = _next_ui


func _change_world(type: CleanType) -> void:
	_clear(_current_world, _world, type)
	_current_world = _create(_next_world, _world)
	_last_world = _next_world


func _clear(target: Node, root: Node, type: CleanType) -> void:
	if target == null: 
		return

	match type:
		CleanType.DELETE:
			_keep_scenes.erase(_keep_scenes.find_key(target))
			target.queue_free()

		CleanType.KEEP_RUNNING:
			target.visible = false
			
		CleanType.REMOVE:
			root.remove_child(target)


func _create(scene: PackedScene, to: Node) -> Node:
	if scene == null:
		return null
	
	var new = null
	if _keep_scenes.has(scene):
		_keep_scenes[scene].visible = true
		new = _keep_scenes[scene]
		if _keep_scenes[scene].get_parent() != to:
			to.add_child(new)
	else:
		new = scene.instantiate()
		to.add_child(new)
		_keep_scenes[scene] = new
	
	return new


func _isEqual(a: PackedScene, b: PackedScene):
	if (a != null && b != null):
		return a.resource_scene_unique_id == b.resource_scene_unique_id
	if (a == null && b == null):
		return true
	return false
