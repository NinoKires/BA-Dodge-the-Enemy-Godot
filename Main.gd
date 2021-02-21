extends Node

signal pineappleHit

export (PackedScene) var Mob
export (PackedScene) var Apple
export (PackedScene) var Pineapple
export (PackedScene) var Melon
export (PackedScene) var HUD

var score
var mobTimerDefault = 0.3
#var mobTemp
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hit():
	pass # Replace with function body.


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$ItemTimer.stop()
	$HUD.show_gameover()
	$Player.hide()
	$Player2.hide()

# lade singleplayer scene
func new_game():
	score = 0
	$BarsGUI/Bars.show()
	$Player.start($StartPosition.position)
	$Player2/CollisionShape2D.disabled = true
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()
	
#lade multiplayer scene
func _on_HUD_multi_start():
	score = 0
	$BarsGUI/Bars.show()
	$BarsGUI/Bars2.show()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()
	$Player.start($StartPosition.position)
	$Player2.start($StartPosition2.position)


func _on_MobTimer_timeout():
	#Path2D dreht sich automatisch um den gesetzten Pfad, wähle einen zufälligen Punkt
	$MobPath/MobSpawnLocation.offset = randi()
	#Mob Instanz wird erstellt und der Szene hinzugefügt
	var mob = Mob.instance()
	#mobTemp = mob
	add_child(mob)
	#Richtung des Mobs wird bestimmt, senkrecht zum Spawnpunkt
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	#Spawnpoint wird zufällig gesetzt
	mob.position = $MobPath/MobSpawnLocation.position
	#Damit der Pfad nicht perfekt grade ist
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	#Geschwindigkeit und Richtung
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

func _on_ItemTimer_timeout():
	#random nummer um item zu bestimmen
	var rand = rand_range(1, 10)
		#Path2D dreht sich automatisch um den gesetzten Pfad, wähle einen zufälligen Punkt
	$ItemPath/ItemSpawnLocation.offset = randi()
	#Mob Instanz wird erstellt und der Szene hinzugefügt
	var apple = Apple.instance()
	var pineapple = Pineapple.instance()
	var melon = Melon.instance()
	#Richtung des Mobs wird bestimmt, senkrecht zum Spawnpunkt
	var direction = $ItemPath/ItemSpawnLocation.rotation + PI / 2
	#Damit der Pfad nicht perfekt grade ist
	direction += rand_range(-PI / 4, PI / 4)
	
	if (rand < 8): #Apfel soll am häufigsten Spawnen
		add_child(apple)
		#Spawnpoint wird zufällig gesetzt
		apple.position = $ItemPath/ItemSpawnLocation.position
		apple.rotation = direction
		#Geschwindigkeit und Richtung
		apple.linear_velocity = Vector2(rand_range(apple.min_speed, apple.max_speed), 0)
		apple.linear_velocity = apple.linear_velocity.rotated(direction)
	elif	 (rand >= 9): #Ananas, starkes Item darum weniger oft
		add_child(pineapple)
		pineapple.position = $ItemPath/ItemSpawnLocation.position
		pineapple.rotation = direction
		pineapple.linear_velocity = Vector2(rand_range(pineapple.min_speed, pineapple.max_speed), 0)
		pineapple.linear_velocity = pineapple.linear_velocity.rotated(direction)
	elif (rand > 9): #Melone sehr impactful darum sehr unwahrscheinlich
		add_child(melon)
		melon.position = $ItemPath/ItemSpawnLocation.position
		melon.rotation = direction
		melon.linear_velocity = Vector2(rand_range(melon.min_speed, melon.max_speed), 0)
		melon.linear_velocity = melon.linear_velocity.rotated(direction)
		$MobTimer.wait_time = 0.2
		

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$ItemTimer.start()

func _on_Player_pineappleHit():
	#score += 10
	$MobTimer.stop()
	yield(get_tree().create_timer(2), "timeout")
	$MobTimer.start()

func _on_Player_melonHit():
	#score += 100
	$MobTimer.wait_time = mobTimerDefault
