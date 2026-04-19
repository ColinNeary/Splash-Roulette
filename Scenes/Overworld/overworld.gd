extends Node3D

@export var player_scene: PackedScene
@onready var players: Node3D = $Players

func _ready() -> void:
	$MultiplayerSpawner.spawn_function = spawn_players
	spawn_players()

func spawn_players() -> CharacterBody3D:
	var player: CharacterBody3D = player_scene.instantiate()
	#players.add_child(player)
	return player
