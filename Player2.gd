extends Area2D
signal hit
signal health_changed
signal died
signal pineappleHit
signal melonHit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400 #Geschwindigkeit des Players
var screen_size #Größe des Game Window

export var max_health = 20
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Geschwindigkeitsberechnung
	var velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed #normalized to set x,y to 1 and stop diagMov from beeing faster than horizMov
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Berechnung der Position
	position += velocity * delta
	# Clamp verhindert, dass Objekt über der Fenstergröße hinaus geht
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Abspielen passender Animationen
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func take_damage(count):
	health -= count
	if (health >= max_health):
		health = max_health
	elif (health <= 0):
		health = 0

	emit_signal("health_changed", health)

func _on_Player2_body_entered(body):
	var tempObjName = body.name
	if (tempObjName == "Pineapple"): 
		emit_signal("pineappleHit")
	elif (tempObjName == "Melon"):
		emit_signal("melonHit")
	take_damage(body.damage)
	#body.hide()
	body.queue_free()
	
	if health <= 0:
		health = 0
		emit_signal("hit")
		emit_signal("died")
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
	#collisionDetection wird disabled damit nur mehr als ein "hit" Signal losgeht
	# set_deferred wartet bis collision vorbei ist, sonst kommt error

func start(pos):
	health = max_health
	emit_signal("health_changed", health)
	position = pos
	show()
	$CollisionShape2D.disabled = false
