extends Node3D

@export var player_scene: PackedScene
@onready var players: Node3D = $Players

func _ready() -> void:
	spawn_players.rpc()

@rpc("call_local", "any_peer", "reliable")
func spawn_players() -> void:
	var player: CharacterBody3D = player_scene.instantiate()
	player.authority_id = multiplayer.get_unique_id()
	players.add_child(player)
