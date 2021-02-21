extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var min_speed = 100
export var max_speed = 300
export var damage = 4
export var objName = "Mob"


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names() #["walk", "swim", "fly"]
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func damage_target(target, damage):
	target.take_damage(damage)
