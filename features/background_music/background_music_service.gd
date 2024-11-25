class_name BackgroundMusicService extends Injectable

enum MusicType {SPLASH, MAIN}

var _player: AudioStreamPlayer


func _init(root: Node) -> void:
	_player = preload("background_music.tscn").instantiate()
	root.add_child(_player, true)


func play(type: MusicType):
	_player["parameters/switch_to_clip"] = MusicType.keys()[type]
	if _player.is_playing() != true:
		_player.play()
