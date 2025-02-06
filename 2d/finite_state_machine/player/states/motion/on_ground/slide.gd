extends "on_ground.gd"

@export var base_max_horizontal_speed := 400.0

@export var air_acceleration := 1000.0
@export var air_deceleration := 2000.0
@export var air_steering_power := 50.0

@export var gravity := 1600.0

var enter_velocity := Vector2()

var max_horizontal_speed := 0.0
var horizontal_speed := 0.0
var horizontal_velocity := Vector2()

var slide_angle := 1.2 # about 70 degrees
var rotation := 0.0
var rotational_speed := 5 #deg
var anim_toggle := false

func initialize(speed: float, velocity: Vector2) -> void:
	horizontal_speed = speed
	if speed > 0.0:
		max_horizontal_speed = speed
	else:
		max_horizontal_speed = base_max_horizontal_speed
	enter_velocity = velocity


func enter() -> void:
	anim_toggle = false
	var input_direction := get_input_direction()
	update_look_direction(input_direction)

	if input_direction:
		horizontal_velocity = enter_velocity
	else:
		horizontal_velocity = Vector2()
		
	owner.get_node(^"AnimationPlayer").play("idle")


func update(delta: float) -> void:
	var input_direction := get_input_direction()
	update_look_direction(input_direction)

	move_horizontally(delta, input_direction)
	animate_slide(delta, input_direction)
	if anim_toggle:
		if abs(rotation) <= 0.0174533: # 1 degree
			finished.emit("previous")


func move_horizontally(delta: float, direction: Vector2) -> void:
	#if direction:
		#horizontal_speed += air_acceleration * delta
	#else:
		#horizontal_speed -= air_acceleration * delta
	#horizontal_speed = clamp(horizontal_speed, 0, max_horizontal_speed)
	horizontal_speed = 1200
	var target_velocity := horizontal_speed * direction.normalized()
	var steering_velocity := (target_velocity - horizontal_velocity).normalized() * air_steering_power
	horizontal_velocity += steering_velocity

	owner.velocity = horizontal_velocity
	owner.move_and_slide()


func animate_slide(delta: float, direction: Vector2) -> void:
	var facing_direction = direction.angle_to(Vector2(1,0))
	print(facing_direction)
	print(rotation)
	if direction.x == 1: # moving right
		print("facing right")
		if anim_toggle:
			rotation += rotational_speed * delta
		else:
			rotation -= rotational_speed * delta
	elif direction.x == -1: # moving left
		print("facing left")
		if anim_toggle:
			rotation -= rotational_speed * delta
		else:
			rotation += rotational_speed * delta
	if rotation < -slide_angle or rotation > slide_angle: # about 60 degrees
		anim_toggle = true
	print(rotation)
	owner.get_node(^"BodyPivot").rotation = rotation
