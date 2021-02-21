extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween
var animated_health = 10

func _ready():
	show()
	var player_max_health = $"../Player".max_health
	bar.max_value = player_max_health
	animated_health = player_max_health

func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value

func _on_Player_health_changed(player_health):
	update_health(player_health)

func update_health(new_value):
	# number_label.text = str(new_value)
	# bar.value = new_value
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6)
	if not tween.is_active():
		tween.start()

func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0)

func _on_HUD_start_game():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", end_color, start_color, 1.0)

func _on_Player2_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0)

func _on_Player2_health_changed(player_health2):
	pass#update_health(player_health2)
