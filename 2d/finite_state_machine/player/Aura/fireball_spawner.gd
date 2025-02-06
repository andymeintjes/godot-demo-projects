extends Node2D

var bullet := preload("FireBall.tscn")


func _on_power_up_finished(next_state_name: String) -> void:
	fire()

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("powerup"):
		#fire()


func fire() -> void:
	if not $CooldownTimer.is_stopped():
		return

	$CooldownTimer.start()
	var new_bullet := bullet.instantiate()
	add_child(new_bullet)
	new_bullet.position = global_position
	new_bullet.direction = owner.look_direction
	#var pivot = new_bullet.get_node(^"Pivot")
	new_bullet.look_at(global_position + owner.look_direction)
 
