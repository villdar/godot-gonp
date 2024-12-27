class_name ScoreManager

extends Node

var ball: Ball

var player_one_score = 0
var player_two_score = 0


func find_and_assign_ball():
	ball = get_tree().get_first_node_in_group("ball")
	if ball != null:
		ball.x_boundry_hit.connect(_on_x_boundry_hit)


func _ready() -> void:
	call_deferred("find_and_assign_ball") 


func _on_x_boundry_hit(boundry: String):
	if boundry == "right_boundry":
		player_one_score += 1
		print("Player 1: ", player_one_score)
	else:
		player_two_score += 1
		print("Player 2: ", player_two_score)
