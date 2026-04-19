extends Node3D

@export var player_scene: PackedScene
@onready var players: Node3D = $Players

func _ready() -> void:
	spawn_players()

func spawn_players() -> void:
	var player: CharacterBody3D = player_scene.instantiate()
	players.add_child(player)
