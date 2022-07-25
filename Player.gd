extends KinematicBody2D
signal bump


# Declare member variables here. Examples:

var vector = Vector2()
var screen_size

var max_velocity = 200
var velocity = 0
var acceleration = 4 # Range 1 - 5
var friction = 7 # Range 5 - 10

var max_turn_speed = 36
var turn_speed = 0
var turn_acceleration = 2 # Range 1 - 3
var turn_friction = 2 # Range 1 - 3


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# hide()


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
	
	if (velocity > max_velocity):
		velocity = max_velocity
	if (velocity < -1 * max_velocity):
		velocity = -1 * max_velocity
	for n in friction:
		if (not Input.is_action_pressed("accelerate") and not Input.is_action_pressed("reverse")):
			if (velocity > 0):
				velocity -= 1
			if (velocity < 0):
				velocity += 1
	
	if (turn_speed > max_turn_speed):
		turn_speed = max_turn_speed
	if (turn_speed < -1 * max_turn_speed):
		turn_speed = -1 * max_turn_speed	
	for n in turn_friction:
		if (not Input.is_action_pressed("turn_left") and not Input.is_action_pressed("turn_right")):
			if (turn_speed > 0):
				turn_speed -= 1
			if (turn_speed < 0):
				turn_speed += 1
	
	rotation += (turn_speed * velocity) / 200000.0
	vector = Vector2(velocity, 0).rotated(rotation)
	vector = move_and_slide(vector)


func start(_pos):
	# position = pos
	show()
	$CollisionPolygon2D.disabled = false


func _on_Player_body_entered(_body):
	# hide()
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionPolygon2D.set_deferred("disabled", true)
