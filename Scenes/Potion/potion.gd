extends Node3D
class_name Potion

@onready var lifetime_timer: Timer = %"Lifetime Timer"


func throw(dir:Vector3, force:float, torque:Vector3) -> void:
	# Create clone
	var clone : Node3D = self.duplicate()
	get_tree().current_scene.add_child(clone)
	
	# Collisions
	clone.global_position = self.global_position
	clone.set_collision_mask_value(1, true) # potion will scan for walls
	clone.set_collision_mask_value(3, true) # potion will scan for enemies
	clone.contact_monitor = true
	clone.max_contacts_reported = 1
	
	# Movement
	clone.freeze = false
	clone.apply_central_impulse(Vector3.ONE * force * dir)
	clone.apply_torque_impulse(torque)
	
	clone.lifetime_timer.start()


# If airborne for too long
func _on_lifetime_timer_timeout() -> void:
	self.queue_free()

# When potion collides with something, freeze for now
func _on_rigid_body_entered(body: Node) -> void:
	pass
	#self.freeze = true
	#self.set_deferred("set_contact_monitor", false)
	#self.call_deferred("reparent", body)
