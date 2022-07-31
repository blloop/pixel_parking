extends CanvasLayer
signal start


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	$StartButton.hide()
	$BackButton.show()
	$Level_1.show()


func _on_BackButton_pressed():
	$BackButton.hide()
	$Level_1.hide()
	$StartButton.show()


func _on_Level_1_pressed():
	$Background.hide()
	$Foreground.hide()
	$Title.hide()
	$StartButton.hide()
	$BackButton.hide()
	$Level_1.hide()
	emit_signal("start")
