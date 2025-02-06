extends "res://state_machine/state.gd"

var counter := 0

func _ready() -> void:
	owner.get_node(^"BodyPivot/PowerUpAura/Sprite2D").hide()

func enter() -> void:
	owner.get_node(^"BodyPivot/PowerUpAura/Sprite2D").show()
	owner.get_node(^"BodyPivot/PowerUpAura/AnimationPlayer").play("glow")

func update(delta: float):
	counter += 1
	if counter >= 100:
		counter = 0
		finished.emit("previous")

func exit() -> void:
	owner.get_node(^"BodyPivot/PowerUpAura/Sprite2D").hide()
