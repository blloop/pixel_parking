extends KinematicBody2D
signal bump


# Declare member variables here. Examples:
var vector = Vector2()
var screen_size

var max_velocity = 50
var velocity = 0
var acceleration = 3

var max_turn_speed = 60
var turn_speed = 0
var turn_acceleration = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_pressed("accelerate"):
		velocity += acceleration
		if Input.is_action_pressed("turn_left"):
			turn_speed -= turn_acceleration
		if Input.is_action_pressed("turn_right"):
			turn_speed += turn_acceleration
	if Input.is_action_pressed("reverse"):
		velocity -= acceleration
		if Input.is_action_pressed("turn_left"):
			turn_speed -= turn_acceleration
		if Input.is_action_pressed("turn_right"):
			turn_speed += turn_acceleration
	
	if Input.is_action_just_pressed("ui_select"):
		if (Player.visible):
			hide()
		else:
			show()
		yield(get_tree().create_timer(1), "timeout")
	
	if (velocity > max_velocity):
		velocity = max_velocity
	if (velocity < -1 * max_velocity):
		velocity = -1 * max_velocity
	if (velocity > 0 and not Input.is_action_pressed("accelerate")):
		velocity -= 1
	if (velocity < 0 and not Input.is_action_pressed("reverse")):
		velocity += 1
	if (velocity > 0 and not Input.is_action_pressed("accelerate")):
		velocity -= 1
	if (velocity < 0 and not Input.is_action_pressed("reverse")):
		velocity += 1
	
	if (turn_speed > max_turn_speed):
		turn_speed = max_turn_speed
	if (turn_speed < -1 * max_turn_speed):
		turn_speed = -1 * max_turn_speed	
	if (not Input.is_action_pressed("turn_left") and not Input.is_action_pressed("turn_right")):
		if (turn_speed > 0):
			turn_speed -= 1
		if (turn_speed < 0):
			turn_speed += 1
	if (not Input.is_action_pressed("turn_left") and not Input.is_action_pressed("turn_right")):
		if (turn_speed > 0):
			turn_speed -= 1
		if (turn_speed < 0):
			turn_speed += 1
	
	if (turn_speed < -30):
		$Wheels.rotation = -0.2
	elif (turn_speed < -15):
		$Wheels.rotation = -0.15
	elif (turn_speed < -2):
		$Wheels.rotation = -0.1
	elif (turn_speed < 2):
		$Wheels.rotation = 0
	elif (turn_speed < 15):
		$Wheels.rotation = 0.1
	elif (turn_speed < 30):
		$Wheels.rotation = 0.15
	else:
		$Wheels.rotation = 0.2
	
	if (velocity < 0):
		rotation -= (turn_speed * pow(velocity, 2)) / 3500000.0
	else:
		rotation += (turn_speed * pow(velocity, 2)) / 3500000.0
	vector = Vector2(velocity / 15, 0).rotated(rotation)
	vector = move_and_collide(vector)
	if vector:
		emit_signal("bump")

#func _on_Player_body_entered(_body):
	# hide()
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionPolygon2D.set_deferred("disabled", true)
