extends Control
class_name Player_UI
@onready var hurt_overlay = $HurtOverlay
@onready var health_bar_bg = $HealthBarBG
@onready var health_bar = $HealthBar
@onready var game_over = $GameOver
@onready var enemyWaveUI = $WaveText
@onready var fade_rect = $FadeRect
var hurt_tween : Tween

func _ready():
	health_bar.value = GameState.get_value("health")
	health_bar_bg.value = health_bar.value
	game_over.hide()
	GameState.player_UI = self
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 2.0)

func _updateEnemyWave(curremtWave:int, maxWave:int):
#func _updateEnemyWave_Timer(curremtWave_timer:int):
	
#	enemyWaveUI_Timer.text = str(curremtWave_timer)

#func TonggleTimer(a: bool):
#	enemyWaveUI_Timer.visible = a


#func _process(_delta):
#	$KeyCounter.text = str(GameState.get_value("key"))
	enemyWaveUI.text = str("Wave: ", curremtWave, "/", maxWave)

func hurt(damage: float):
	health_bar.value -= damage
	GameState.set_value("health", health_bar.value)
	
	hurt_overlay.modulate = Color.WHITE
	if hurt_tween:
		hurt_tween.kill()
	hurt_tween = create_tween()
	hurt_tween.parallel().tween_property(hurt_overlay, "modulate", Color.TRANSPARENT, 0.5)
	hurt_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	hurt_tween.parallel().tween_property(health_bar_bg, "value", health_bar.value, 0.6)
	if health_bar.value <= 0:
		get_parent().die()

func show_gameover():
	game_over.modulate.a = 0.0
	game_over.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var tween = create_tween()
	tween.parallel().tween_property(fade_rect, "modulate:a", 1.0, 2.0)
	tween.parallel().tween_property(game_over, "modulate:a", 1.0, 2.0)

func _on_restart_button_pressed():
	GameState.set_value("health", 100)
	game_over.hide()
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.8)
	tween.tween_callback(func():
		get_tree().reload_current_scene()
	)

func _on_quit_button_pressed():
	get_tree().quit()
