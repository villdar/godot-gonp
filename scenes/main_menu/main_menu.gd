extends Node2D


@onready var start_button = %StartButton
@onready var quit_button = %QuitButton
@onready var p1_high_score = %P1HighScore
@onready var p2_high_score = %P2HighScore

var high_scores = {}

func _ready() -> void:
	high_scores = SaveAndLoadManager.read_high_scores()
	start_button.button_down.connect(_on_start_button_down)
	quit_button.button_down.connect(_on_quit_button_down)
	
	p1_high_score.text = str(high_scores["player_one_score"])
	p2_high_score.text = str(high_scores["player_two_score"])

func _on_start_button_down() -> void:
	MainSceneManager.load_scene("res://scenes/world/world.tscn")


func _on_quit_button_down() -> void:
	MainSceneManager.quit()
