extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var min_speed = 50
export var max_speed = 150
export var damage = -2 # -2 bc the "takeDmg" function goes like x -= y
export var objName = "Apple"

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_types = $AnimatedSprite.frames.get_animation_names() #["walk", "swim", "fly"]
	$AnimatedSprite.animation = item_types[randi() % item_types.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
