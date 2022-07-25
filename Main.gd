extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position.x = $SpawnPosition.position.x
	$Player.position.y = $SpawnPosition.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label1.text = "Velocity:" + str($Player.velocity)
	$Label2.text = "Turn Speed:" + str($Player.turn_speed)
	
	$Label3.text = "Parked:" + str($ParkingGoal.touch_center and not $ParkingGoal.touch_border)
	
	#if ($ParkingGoal.touch_center and not $ParkingGoal.touch_border):
