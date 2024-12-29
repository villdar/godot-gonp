class_name UI

extends CanvasLayer

@export var pause_manager: PauseManager

@onready var resume_button = %ResumeButton
@onready var main_menu_button = %MainMenuButton
@onready var quit_button = %QuitButton

func _ready() -> void:
	resume_button.button_down.connect(_on_resume_button_down)
	main_menu_button.button_down.connect(_on_main_menu_button_down)
	quit_button.button_down.connect(_on_quit_button_down)


func set_player_one_score_text(newScore: String):
	%P1ScoreLabel.text = newScore


func set_player_two_score_text(newScore: String):
	%P2ScoreLabel.text = newScore


func set_pause_menu_visible(is_visible: bool):
	%PauseScreen.visible = is_visible


func _on_resume_button_down() -> void:
	pause_manager.set_pause(false)


func _on_main_menu_button_down() -> void:
	pause_manager.set_pause(false)
	MainSceneManager.load_scene("res://scenes/main_menu/main_menu.tscn")


func _on_quit_button_down() -> void:
	MainSceneManager.quit()
