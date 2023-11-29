@tool
extends Node

var _next : int = 0
var _audio_stream_players : Array[AudioStreamPlayer]

@export var count : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_child_count() == 0:
		print("No audio_stream_child found")
		return
	
	var child : Node = get_child(0)
	if child is AudioStreamPlayer:
		_audio_stream_players.push_back(child)
		for i in range(count):
			var duplicate_node : AudioStreamPlayer = child.duplicate() as AudioStreamPlayer
			add_child(duplicate_node)
			_audio_stream_players.push_back(duplicate_node)
	
func _get_configuration_warnings() -> PackedStringArray:
	if get_child_count() == 0:
		return ["No children found. Expected one AudioStreamPlayer child."]
	if not get_child(0) is AudioStreamPlayer:
		return ["Expected first child to be an AudioStreamPlayer."]
	return []
	
func play_sound() -> void:
	if _audio_stream_players.size() == 0:
		return
	
	if not _audio_stream_players[_next].playing:
		_audio_stream_players[_next].play()
		_next = (_next + 1) % _audio_stream_players.size()

