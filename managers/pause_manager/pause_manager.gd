class_name PauseManager

extends Node

@export var ui: UI

var is_paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = !is_paused
		get_tree().paused = is_paused
		ui.set_pause_menu_visible(is_paused)


func set_pause(new_is_paused_value: bool):
	is_paused = new_is_paused_value
	get_tree().paused = is_paused
	ui.set_pause_menu_visible(is_paused)
