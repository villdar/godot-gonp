class_name SceneManager

extends Node


func quit():
	get_tree().quit()


func load_scene(path_of_scene_to_load: String):
	get_tree().change_scene_to_file(path_of_scene_to_load)
