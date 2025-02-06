extends "../motion.gd"

var speed := 0.0
var velocity := Vector2()

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit("jump")
	if event.is_action_pressed("slide"):
		finished.emit("slide")
		
	return super.handle_input(event)
