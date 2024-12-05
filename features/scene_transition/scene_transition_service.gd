class_name SceneTransitionService extends Injectable

enum CleanType {DELETE, KEEP_RUNNING, REMOVE}


var _transition_screen: TransitionScreen
var _container : Node

var _last : PackedScene
var _next : PackedScene
var _type : CleanType

var _current: Node
var _current_prefinished = false

var _keep_scenes : Dictionary = {}


func _init(container: Node, transition_screen: TransitionScreen = null):
	_container = container
	_transition_screen = transition_screen


func change(new: PackedScene, type: CleanType = CleanType.DELETE) -> void:
	_next = new
	_type = type

	if _isEqual(_last, _next):
		return
	
	_clear(_current, _container, _type)
	_current = _create(_next, _container)
	_last = _next


func transit(new: PackedScene, type: CleanType = CleanType.DELETE) -> void:
	if _transition_screen:
		await _transition_screen.play(false)
	
	change(new, type)
	
	if  _transition_screen:
		_transition_screen.play(true)


func finish_pre_hide(scene: Node) -> void:
	if scene == _current:
		_current_prefinished = true


func _clear(target: Node, root: Node, type: CleanType) -> void:
	if target == null: 
		return

	# target.pre_hide(self.finish_pre_hide)

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
		return a.resource_path == b.resource_path
	if (a == null && b == null):
		return true
	return false
