class_name ScoreManager

extends Node

@export var ui: UI

var ball: Ball

var player_one_score = 0
var player_two_score = 0

var high_scores = {}

func find_and_assign_ball():
	ball = get_tree().get_first_node_in_group("ball")
	if ball != null:
		ball.x_boundry_hit.connect(_on_x_boundry_hit)


func _ready() -> void:
	call_deferred("find_and_assign_ball")
	high_scores = SaveAndLoadManager.read_high_scores()


func _on_x_boundry_hit(boundry: String):
	if boundry == "right_boundry":
		player_one_score += 1
		ui.set_player_one_score_text(str(player_one_score))
		if player_one_score > high_scores["player_one_score"]:
			high_scores["player_one_score"] = player_one_score
			SaveAndLoadManager.save_high_score(high_scores)
	else:
		player_two_score += 1
		ui.set_player_two_score_text(str(player_two_score))
		if player_two_score > high_scores["player_two_score"]:
			high_scores["player_two_score"] = player_two_score
			SaveAndLoadManager.save_high_score(high_scores)
