extends Node3D
class_name Gibblets

func spawn_self() -> void:
	self.call_deferred("reparent", get_tree().current_scene)
	self.process_mode = Node.PROCESS_MODE_INHERIT
	self.visible = true

func _on_lifetime_timer_timeout() -> void:
	self.queue_free()
