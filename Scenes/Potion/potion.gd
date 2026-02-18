extends Node3D
class_name Potion

@onready var rigid_body: RigidBody3D = %RigidBody3D
@onready var lifetime_timer: Timer = %"Lifetime Timer"


func throw(dir:Vector3, force:float) -> void:
	# Create clone
	var clone : Node3D = self.duplicate()
	get_tree().current_scene.add_child(clone)
	
	# Collisions
	clone.scale = Vector3(.8, .8, .8)
	clone.global_position = self.global_position
	clone.rigid_body.set_collision_mask_value(1, true) # potion will scan for walls
	clone.rigid_body.set_collision_mask_value(2, true) # potion will scan for enemies
	clone.rigid_body.contact_monitor = true
	clone.rigid_body.max_contacts_reported = 1
	
	# Movement
	clone.freeze = false
	var random_torque = Vector3(randf_range(-.1, .1), randf_range(-.1, .1), randf_range(-.1, .1))
	clone.apply_central_impulse(Vector3.ONE * force * dir)
	clone.apply_torque_impulse(random_torque)
	
	clone.lifetime_timer.start()


# If airborne for too long
func _on_lifetime_timer_timeout() -> void:
	self.queue_free()

# When potion collides with something, freeze for now
func _on_rigid_body_entered(body: Node) -> void:
	self.rigid_body.freeze = true
	self.rigid_body.set_deferred("set_contact_monitor", false)
	self.call_deferred("reparent", body)
