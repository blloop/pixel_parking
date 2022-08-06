extends Node
# signal start


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ($ParkingGoal.touch_center and not $ParkingGoal.touch_border):
		$ParkingGoal/AnimatedSprite.animation = "finished";
	else:
		$ParkingGoal/AnimatedSprite.play("waiting");

func _reset_player():
	$Player.position.x = $SpawnPosition.position.x
	$Player.position.y = $SpawnPosition.position.y
	$Player.rotation = $SpawnPosition.rotation	
	$Player.velocity = 0
	$Player.turn_speed = 0
	

func _bump():
	_reset_player()


func _on_HUD_start():
	_reset_player()
