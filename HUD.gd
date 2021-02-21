extends CanvasLayer

signal start_game
signal multi_start
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_gameover():
	show_message("Game Over")
	#warte
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	#One-shot timer und warte
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$MulitplrButton.show()
	$InfoButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MulitplrButton.hide()
	$InfoButton.hide()
	emit_signal("start_game")

func _on_InfoButton_pressed():
	$InfoButton.hide()
	$InfoExitButton.show()
	$InfoLabel.show()
	$Message.hide()

func _on_InfoExitButton_pressed():
	$InfoButton.show()
	$Message.show()
	$InfoExitButton.hide()
	$InfoLabel.hide()

func _on_MulitplrButton_pressed():
	$StartButton.hide()
	$MulitplrButton.hide()
	$InfoButton.hide()
	emit_signal("multi_start")
