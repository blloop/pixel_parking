extends Area2D


# Declare member variables here. Examples:
var touch_border = false
var touch_center = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ParkingGoal_body_entered(_body):
	touch_border = true
	
func _on_ParkingGoal_body_exited(_body):
	touch_border = false
	
func _on_Center_body_entered(_body):
	touch_center = true
	
func _on_Center_body_exited(_body):
	touch_center = false
